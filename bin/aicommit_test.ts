import {
  buildPrompt,
  formatCommitMessage,
  formatNotePayload,
  main,
  parseArgs,
  requestCommitMessageFromOpenRouter,
} from "./aicommit";

function assert(condition: unknown, message = "assertion failed"): asserts condition {
  if (!condition) {
    throw new Error(message);
  }
}

function assertEquals<T>(actual: T, expected: T, message?: string): void {
  if (actual !== expected) {
    throw new Error(message ?? `expected ${JSON.stringify(expected)}, got ${JSON.stringify(actual)}`);
  }
}

function assertMatch(actual: string, expected: RegExp, message?: string): void {
  if (!expected.test(actual)) {
    throw new Error(message ?? `expected ${JSON.stringify(actual)} to match ${expected}`);
  }
}

function requestBody(init: RequestInit | undefined): string {
  return String((init as RequestInit & { body?: BodyInit | null } | undefined)?.body ?? "");
}

async function runCommand(
  command: string,
  args: string[],
  cwd: string,
): Promise<{ code: number; stdout: string; stderr: string }> {
  const child = new Deno.Command(command, {
    args,
    cwd,
    stdout: "piped",
    stderr: "piped",
  }).spawn();
  const [status, stdout, stderr] = await Promise.all([
    child.status,
    new Response(child.stdout).text(),
    new Response(child.stderr).text(),
  ]);
  return { code: status.code, stdout, stderr };
}

async function git(cwd: string, ...args: string[]): Promise<string> {
  const result = await runCommand("git", args, cwd);
  if (result.code !== 0) {
    throw new Error(result.stderr || result.stdout);
  }
  return result.stdout.trim();
}

async function setupRepo(): Promise<string> {
  const repo = await Deno.makeTempDir();
  await git(repo, "init");
  await git(repo, "config", "user.name", "Test User");
  await git(repo, "config", "user.email", "test@example.com");
  await Deno.writeTextFile(`${repo}/README.md`, "hello\n");
  await git(repo, "add", "README.md");
  await git(repo, "commit", "-m", "init: seed repo");
  return repo;
}

async function stageChange(repo: string, content: string): Promise<void> {
  await Deno.writeTextFile(`${repo}/README.md`, content);
  await git(repo, "add", "README.md");
}

Deno.test("parseArgs handles contexts and flags", () => {
  const options = parseArgs([
    "-c",
    "one",
    "--context=two",
    "--context-file",
    "ctx.txt",
    "--dry-run",
    "--yes",
    "--no-notes",
  ]);
  assertEquals(options.contexts.join(","), "one,two");
  assertEquals(options.contextFiles.join(","), "ctx.txt");
  assert(options.dryRun);
  assert(options.yes);
  assert(options.noNotes);
});

Deno.test("format helpers keep output stable", () => {
  assertEquals(formatCommitMessage("test: add command", "because reasons"), "test: add command\n\nbecause reasons");
  const note = formatNotePayload(["first plan", "second plan"], "openrouter/auto", new Date("2026-03-07T00:00:00Z"));
  assertMatch(note, /^aicommit-context/m);
  assertMatch(note, /--- context 1 ---/);
  assertMatch(note, /second plan/);
});

Deno.test("buildPrompt prefers repository guide over user guide", () => {
  const prompt = buildPrompt({
    diffStat: "README.md | 1 +",
    diff: "diff --git a/README.md b/README.md",
    recentSubjects: ["docs: update readme"],
    recentMessages: [],
    repoStyleGuide: "Repo guide",
    userStyleGuide: "User guide",
    contexts: [],
  });
  const joined = prompt.map((message) => message.content).join("\n");
  assertMatch(joined, /Repo guide/);
  assert(!joined.includes("User guide"), "repo guide should suppress user guide");
});

Deno.test("OpenRouter request falls back when structured output is rejected", async () => {
  const seenBodies: string[] = [];
  let callCount = 0;
  const fetchStub: typeof fetch = async (_input, init) => {
    callCount += 1;
    seenBodies.push(requestBody(init));
    if (callCount === 1) {
      return new Response(JSON.stringify({ error: "structured output not supported" }), { status: 400 });
    }
    return new Response(
      JSON.stringify({
        choices: [
          {
            message: {
              content: JSON.stringify({ subject: "feat: fallback works", body: "" }),
            },
          },
        ],
      }),
      { status: 200 },
    );
  };

  const message = await requestCommitMessageFromOpenRouter(
    {
      apiKey: "test-key",
      baseUrl: "https://example.com/api/v1",
      model: "openrouter/auto",
      messages: [{ role: "user", content: "hi" }],
    },
    fetchStub,
  );

  assertEquals(message.subject, "feat: fallback works");
  assertEquals(callCount, 2);
  assertMatch(seenBodies[0], /response_format/);
  assert(!seenBodies[1].includes("response_format"), "fallback body should omit response_format");
});

Deno.test({
  name: "main dry-run prints a message without committing",
  permissions: { read: true, write: true, run: true, env: true },
  fn: async () => {
  const repo = await setupRepo();
  await stageChange(repo, "dry run change\n");

  const outputs: string[] = [];
  const errors: string[] = [];
  const exitCode = await main(["--dry-run"], {
    cwd: repo,
    output: (text) => outputs.push(text),
    error: (text) => errors.push(text),
    generateCommitMessage: async () => ({
      subject: "docs: test dry run",
      body: "",
      raw: "docs: test dry run",
    }),
  });

  const headSubject = await git(repo, "log", "-1", "--format=%s");
  assertEquals(exitCode, 0);
  assertEquals(headSubject, "init: seed repo");
  assertMatch(outputs.join("\n"), /docs: test dry run/);
  assertEquals(errors.length, 0);
  },
});

Deno.test({
  name: "main accepts y and writes a git note for explicit context",
  permissions: { read: true, write: true, run: true, env: true },
  fn: async () => {
  const repo = await setupRepo();
  await stageChange(repo, "commit with note\n");

  const exitCode = await main(["-c", "LLM plan: update README"], {
    cwd: repo,
    isInteractive: () => true,
    prompt: async () => "y",
    generateCommitMessage: async () => ({
      subject: "docs: add note test",
      body: "",
      raw: "docs: add note test",
    }),
  });

  const headSubject = await git(repo, "log", "-1", "--format=%s");
  const note = await git(repo, "notes", "--ref=commits", "show", "HEAD");
  assertEquals(exitCode, 0);
  assertEquals(headSubject, "docs: add note test");
  assertMatch(note, /LLM plan: update README/);
  },
});

Deno.test({
  name: "main uses repo COMMITS.md before HOME COMMITS.md",
  permissions: { read: true, write: true, run: true, env: true },
  fn: async () => {
  const repo = await setupRepo();
  await stageChange(repo, "style guide selection\n");
  await Deno.writeTextFile(`${repo}/COMMITS.md`, "Repo style guide wins");

  const fakeHome = await Deno.makeTempDir();
  await Deno.writeTextFile(`${fakeHome}/COMMITS.md`, "User style guide");

  const requestBodies: string[] = [];
  const exitCode = await main(["--dry-run"], {
    cwd: repo,
    envGet: (name) => {
      if (name === "OPENROUTER_API_KEY") return "test-key";
      if (name === "HOME") return fakeHome;
      if (name === "AICOMMIT_BASE_URL") return "https://example.com/api/v1";
      return undefined;
    },
    fetch: async (_input, init) => {
      requestBodies.push(requestBody(init));
      return new Response(
        JSON.stringify({
          choices: [
            {
              message: {
                content: JSON.stringify({ subject: "docs: use repo guide", body: "" }),
              },
            },
          ],
        }),
        { status: 200 },
      );
    },
  });

  assertEquals(exitCode, 0);
  assertMatch(requestBodies[0], /Repo style guide wins/);
  assert(!requestBodies[0].includes("User style guide"), "user guide should not appear when repo guide exists");
  },
});

Deno.test({
  name: "main saves pending note payload when git notes fails",
  permissions: { read: true, write: true, run: true, env: true },
  fn: async () => {
  const repo = await setupRepo();
  await stageChange(repo, "pending note\n");

  const errors: string[] = [];
  const exitCode = await main(["--yes", "-c", "LLM plan"], {
    cwd: repo,
    error: (text) => errors.push(text),
    runGit: async (options) => {
      if (options.args[0] === "notes") {
        return { code: 1, stdout: "", stderr: "notes disabled for test" };
      }
        return await (async () => {
          const child = new Deno.Command("git", {
            args: ["-C", options.cwd, ...options.args],
            stdin: options.interactive ? "inherit" : "null",
            stdout: options.interactive ? "inherit" : "piped",
            stderr: options.interactive ? "inherit" : "piped",
          }).spawn();
          if (options.interactive) {
            const status = await child.status;
            return { code: status.code, stdout: "", stderr: "" };
          }
          const [status, stdout, stderr] = await Promise.all([
            child.status,
            child.stdout ? new Response(child.stdout).text() : Promise.resolve(""),
          child.stderr ? new Response(child.stderr).text() : Promise.resolve(""),
        ]);
        return { code: status.code, stdout, stderr };
      })();
    },
    generateCommitMessage: async () => ({
      subject: "docs: pending note fallback",
      body: "",
      raw: "docs: pending note fallback",
    }),
  });

  const headSha = await git(repo, "rev-parse", "HEAD");
  const pendingPath = `${repo}/.git/aicommit/pending-note-${headSha}.md`;
  const pendingText = await Deno.readTextFile(pendingPath);
  assertEquals(exitCode, 0);
  assertMatch(pendingText, /LLM plan/);
  assert(errors.some((line) => line.includes("pending-note-")), "expected pending note warning");
  },
});

Deno.test({
  name: "main fails when there are no staged changes",
  permissions: { read: true, write: true, run: true, env: true },
  fn: async () => {
  const repo = await setupRepo();
  const errors: string[] = [];

  const exitCode = await main(["--dry-run"], {
    cwd: repo,
    error: (text) => errors.push(text),
    envGet: (name) => {
      if (name === "OPENROUTER_API_KEY") return "test-key";
      if (name === "AICOMMIT_BASE_URL") return "https://example.com/api/v1";
      return Deno.env.get(name);
    },
    fetch: async () => {
      throw new Error("fetch should not run without staged changes");
    },
  });

  assertEquals(exitCode, 1);
  assert(errors.some((line) => line.includes("no staged changes found")));
  },
});
