# banyan's dotfiles

## Setup

Requires [mise](https://mise.jdx.dev/), [Rust](https://rustup.rs/) (`cargo`)
and an authenticated `gh` (`gh auth login`).

```zsh
mkdir -p ~/git
git clone https://github.com/banyan/config ~/git/config
cd ~/git/config

# Run all setup tasks (dotfiles, nvim, ghostty, orca, deno, tools, bin)
mise run setup
```

### Individual tasks

| Task | Description |
|------|-------------|
| `mise run install:dotfiles` | Symlink dotfiles into `$HOME` |
| `mise run install:nvim` | Install neovim and symlink `~/.config/nvim` |
| `mise run install:ghostty` | Symlink `~/.config/ghostty` |
| `mise run install:orca` | Symlink `~/.orca/keybindings.json` |
| `mise run install:deno` | Install deno (still needed by `bin/aicommit`, `bin/claude-quota`) |
| `mise run install:tools` | Install `git modified_files` (cargo) and `gh contrib` (gh extension) |
| `mise run install:bin` | Symlink `bin/` commands into `~/bin` |
| `mise run cleanup` | Remove orphaned symlinks |

## Notes

- This repo is zsh-first (`.zshenv`, `.zshrc`).
