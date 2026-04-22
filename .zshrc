# banyan's .zshrc file
# Kohei Hasegawa <ameutau@gmail.com>
# https://github.com/banyan/config

# Complement
typeset -U fpath

# Predictive input from history (man zshcontrib)
autoload -U predict-on

# Select completion candidates with arrow keys (candidates are colorized)
zstyle ':completion:*:default' menu select=1
# Ignore case during completion (but keep uppercase letters as typed)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# Only include directories on cdpath when no local candidates exist
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*' list-colors 'di=;00;38;05;44' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=00;38;05;44' 'cd=00;38;05;44'

# vcs_info
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '[%b|%a]'

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"

    if git rev-parse 2> /dev/null; then
        repo=`git rev-parse --show-toplevel`

        # http://stnard.jp/2010/10/25/402/
        if [[ -e $repo/.git/refs/stash ]]; then
            stashes=$(git stash list 2>/dev/null | wc -l)
            psvar[2]="[@${stashes// /}]"
        fi
    fi
}
add-zsh-hook precmd _update_vcs_info_msg

# plugins
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-rust

zinit wait lucid blockf light-mode for \
    @'zsh-users/zsh-autosuggestions' \
    @'zsh-users/zsh-completions' \
    @'g-plane/zsh-yarn-autocompletions' \
    @'zsh-users/zsh-history-substring-search' \
    @'momo-lab/zsh-replace-multiple-dots' \
    @'zdharma-continuum/fast-syntax-highlighting'

zinit light banyan/firebase-zsh
zinit load agkozak/zsh-z
zinit light banyan/zsh-auto-escape
zinit light banyan/zsh-fzf-git-worktree

fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
zinit cdreplay -q

ZSH_AUTO_ESCAPE_PREFIXES=('v' 'code' 'd' 'dic' 'git add' 'git co', 'mv', 'ls', 'ls -la', 'jest')
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#B19CD9"

# prompt
PROMPT_SYMBOL="❯"

# Show hostname + pink ❯ only on Mac mini
if [[ "$(hostname)" == *"Mac-mini"* ]]; then
  PROMPT="%F{158}[mini]%f %(?,%F{213}${PROMPT_SYMBOL}%f,%F{227}${PROMPT_SYMBOL}%f) "
else
  PROMPT="%(?,%F{38}${PROMPT_SYMBOL}%f,%F{227}${PROMPT_SYMBOL}%f) "
fi
VCS_INFO='%1(v|%F{248}%1v%f%F{226}%2v%f|)'
RPROMPT='${VCS_INFO}%F{14}[%~]%f'

# Setup options
setopt APPEND_HISTORY         # Append to .zsh_history instead of overwriting
setopt AUTO_CD                # Run cd when only a directory name is entered
setopt AUTO_LIST              # Automatically list candidates when multiple matches exist
setopt AUTO_MENU              # Cycle completion candidates with TAB
setopt AUTO_PARAM_SLASH       # Append slash if a completed variable value is a directory
setopt AUTO_PARAM_KEYS        # Auto-complete matching parentheses and similar pairs
setopt AUTO_RESUME            # Resume suspended process when command name matches
setopt CHECK_JOBS             # Warn on exit if there are running jobs
setopt CORRECT                # Command spell-checking
setopt EXTENDED_GLOB          # Treat #, ~, ^ as pattern characters in filenames
setopt EXTENDED_HISTORY       # Save zsh start/end timestamps in the history file
setopt GLOB_DOTS              # Match dotfiles without requiring an explicit leading dot
setopt HASH_CMDS              # Hash command paths as commands are executed
setopt HIST_EXPIRE_DUPS_FIRST # Expire older entries first when duplicates exist
setopt HIST_NO_STORE          # Do not store the history command itself
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate history entries
setopt HIST_IGNORE_DUPS       # Do not add a command if it matches the previous one
setopt HIST_REDUCE_BLANKS     # Trim extra spaces before saving history
setopt HIST_SAVE_NO_DUPS      # Skip duplicates when writing the history file
setopt INC_APPEND_HISTORY     # Append history incrementally
setopt LIST_TYPES             # Show file type markers in completion lists
setopt MARK_DIRS              # Append / when filename expansion matches a directory
setopt NUMERIC_GLOB_SORT      # Sort numbers numerically
setopt NOBEEP                 # Disable beep
setopt NO_FLOW_CONTROL        # disable C-q, C-s
setopt PROMPT_SUBST           # Enable parameter, command, and arithmetic expansion in PROMPT
setopt SHARE_HISTORY          # Share history across shells
setopt AUTOPUSHD              # Automatically push directories when running cd
setopt PUSHD_IGNORE_DUPS      # Do not push duplicate directories with pushd
setopt TRANSIENT_RPROMPT      # Show only the current-status RPROMPT
unsetopt CORRECT_ALL          # Do not spell-check arguments/files

# Setup vars
export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export EDITOR=nvim

HISTFILE=$HOME/.zsh_history
HISTSIZE=300000
SAVEHIST=300000
REPORTTIME=3

# Aliases
case "$OSTYPE" in
    freebsd*|darwin*)
        alias ls='ls -G -w'
    ;;
    *)
        alias ls='ls --color=auto'
    ;;
esac

alias -g P='| pbcopy'
alias l='ls -la'
alias wget='wget --no-check-certificate'
alias diff='colordiff'
alias less='less -R'
alias sed='gsed'
alias date='gdate'
alias T='tilex'
alias tt='tmux new-session \; new-window \; new-window \; new-window \; new-window \; new-window \; new-window \; new-window'
alias pp='popd'
alias ocaml='rlwrap ocaml'
alias t='yarn test'
alias ttig='tig --follow'
alias tl='translate'
alias cat='bat'
alias chrome='open -a "Google Chrome.app"'
alias tree='tree -N'
alias rg="rg --hidden"
alias ag="rg --hidden"  # muscle memory shim; remove once habits are updated
alias v="nvim"
alias vi="nvim"
alias u="cd-gitroot"

# terraform - use cargo-make to handle tfvars easily
alias ti='mise run init'
alias tp='mise run plan'
alias ta='mise run apply'
alias ts='mise run show'

# mise
alias mi='mise install'
alias mu='mise upgrade'

# git
alias g="git"
alias dic='dc'
alias m="m"
alias b='git branch'
alias ai='aicommit'
alias k='nvim -p `git modified_files`'
alias C='code `git modified_files`'
alias -g s='git st'
alias d='git diff'
alias A='fzf-git-add'
alias a='git add -A'
alias o='ghopen'
alias p="git p"
alias pr="gh pr create --web"
alias pl="git pl"
alias R="git reset"
alias -g G='| rg --color=always'
alias -g H='| head -n 10'
alias gm="git modified_files"
alias yo='git yo'
alias ran="git ran -e '^s|^a|^dic|^git|^ran'"
alias w="fzf-git-worktree"

# LLMs
alias c="claude --dangerously-skip-permissions"
alias codex="codex --dangerously-bypass-approvals-and-sandbox"
alias gemini="gemini --yolo"

# for Mac
alias there="fcd"
alias here="open ."

alias python=/usr/bin/python3
alias pip=/usr/bin/pip3

# Keybindings
bindkey -e       # emacs-style keybindings
# Delete backward from the cursor position
# override kill-whole-line
bindkey '^U' backward-kill-line

# Misc
# Limit core dump size
limit coredumpsize 102400
# While typing (e.g. ls /usr/local/etc), let C-w delete by path segment
# default  : ls /usr/local → ls /usr/ → ls /usr → ls /
# With this setting: ls /usr/local -> ls /usr/ -> ls /
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

function is_firebase_project() {
	local firebase_dir=$(get_firebase_dir)
	if [[ -n $firebase_dir ]]
	then
		echo 1
	fi
}

function get_firebase_dir() {
	local dir="$(pwd)"

	# Keep checking up, we may be in a subdir
	while [[ $dir != '/' ]]
	do
		local target="$dir/firebase.json"

		if [[ -e $target ]]
		then
				echo $dir
				break
		else
				dir=$(dirname ${dir:A})
		fi
	done
}

# switch firebase project
function fx() {
  # `is_firebase_project` and `get_firebase_dir` are depends on https://github.com/Seqi/firebase-zsh
  # also jq, fzf and firebase-tools are used.
  if [[ $(is_firebase_project) ]]; then
      local firebaserc="$(get_firebase_dir)/.firebaserc"
      local project=$(cat $firebaserc | jq -r '.targets|keys[]' | fzf --no-info)

      if [ "$project" != "" ]; then
          firebase use "${project}"
      fi
  else
      echo ".firebaserc was not found."
  fi
}

# Misc

# git diff --cached
function dc() {
    local opt
    opt=$*
    git diff --cached $opt
}

# Check 256 colors
function pcolor() {
    for ((f = 0; f < 255; f++)); do
        printf "\e[38;5;%dm %3d#\e[m" $f $f
        if [[ $f%8 -eq 7 ]] then
            printf "\n"
        fi
    done
    echo
}

function m() {
  local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  if [ -z "$default_branch" ]; then
    git remote set-head origin --auto >/dev/null 2>&1
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
  fi
  if [ -z "$default_branch" ]; then
    default_branch=$(git branch -l main master --format '%(refname:short)' | head -1)
  fi

  local main_worktree=$(git worktree list --porcelain | head -1 | grep "^worktree " | cut -d' ' -f2)
  local current_dir=$(pwd)

  local is_worktree=$(git worktree list --porcelain | grep "^worktree $current_dir$" | grep -v "^worktree $main_worktree$")

  if [ -n "$is_worktree" ]; then
    local worktree_name=$(basename "$current_dir")

    if [ "$worktree_name" = "main" ]; then
      cd "$(dirname "$current_dir")"
      git checkout "$default_branch"
    else
      git checkout "$worktree_name/$default_branch"
    fi
  else
    git checkout "$default_branch"
  fi
}

function rg_last_argument_then_peco_to_vim() {
    last_command=$history[$[HISTCMD-1]];
    last_command_array=("${(s/ /)last_command}")
    vim `rg $@ $last_command_array[-1] | peco | awk -F : '{print "-c " $2 " " $1}'`
}

function rg_last_argument_then_peco_to_vim_all() {
    last_command=$history[$[HISTCMD-1]];
    last_command_array=("${(s/ /)last_command}")
    vim -p `rg -l $last_command_array[-1]`
}

function rgv () {
  vim $(rg $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

ghopen() {
  if [ "$#" -eq 0 ]; then
    gh browse
    return
  fi

  local file=$1
  local ref=${2:-$(git rev-parse HEAD)}
  local remote_url=$(git remote get-url origin)
  local gh_url="https://github.com/$(echo $remote_url | sed 's|.*github.com[:/]||' | sed 's|\.git$||')"
  local repo_root=$(git rev-parse --show-toplevel)
  local relative_path="${PWD#$repo_root}"

  open "${gh_url}/blob/${ref}${relative_path}/${file}"
}

export FZF_DEFAULT_OPTS='--height 90% --layout=reverse --border -x --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up'

[ -f ~/.zsh.d/.fzf.zsh ] && source ~/.zsh.d/.fzf.zsh

kill_port() {
  local pid
  pid=$(lsof -n -i -P | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

export FZF_CTRL_R_OPTS="--prompt=\"History > \""

# opam configuration
test -r $HOME/.opam/opam-init/init.zsh && . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

function gcloud-activate() {
  name="$1"
  project="$2"
  echo "gcloud config configurations activate \"${name}\""
  gcloud config configurations activate "${name}"
}

function gx-complete() {
  _values $(gcloud config configurations list | awk '{print $1}')
}

function gx() {
  name="$1"
  if [ -z "$name" ]; then
    line=$(gcloud config configurations list | peco)
    name=$(echo "${line}" | awk '{print $1}')
  else
    line=$(gcloud config configurations list | grep "$name")
  fi
  project=$(echo "${line}" | awk '{print $4}')
  gcloud-activate "${name}" "${project}"
}

compdef gx-complete gx

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}zinit%F{220} Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

ch() {
  local cols title_cols date_cols sep chrome_root opener prompt header query output key exact_label uniq_label
  local exact_mode uniq_mode tmpdir profile_dir src dst base i
  local -a fzf_opts lines selections urls profile_dirs copied_dbs attach_sql union_parts
  cols=$COLUMNS
  title_cols=$(( cols / 3 ))
  date_cols=16
  (( title_cols < 24 )) && title_cols=24
  sep='{::}'
  exact_mode=0
  uniq_mode=0
  query="$*"

  if [ "$(uname)" = "Darwin" ]; then
    chrome_root="$HOME/Library/Application Support/Google/Chrome"
    opener=open
  else
    chrome_root="$HOME/.config/google-chrome"
    opener=xdg-open
  fi

  # Copy every profile's History DB into a tmpdir, then UNION them.
  # Chrome's Default profile can be empty (missing `urls` table) when the
  # user's real data lives in "Profile 2" etc. — copy them all.
  tmpdir=$(mktemp -d -t ch-history) || return 1
  profile_dirs=("$chrome_root"/Default "$chrome_root"/Profile*(N))
  copied_dbs=()
  for profile_dir in "${profile_dirs[@]}"; do
    src="$profile_dir/History"
    [[ -f "$src" ]] || continue
    base="${profile_dir:t}"
    dst="$tmpdir/${base// /_}.sqlite"
    cp -f "$src" "$dst" 2>/dev/null || continue
    # Skip DBs that don't have a `urls` table (e.g. freshly-reset profile).
    sqlite3 "$dst" "select 1 from urls limit 1" >/dev/null 2>&1 || continue
    copied_dbs+=("$dst")
  done

  if (( ${#copied_dbs[@]} == 0 )); then
    echo "ch: no Chrome profile with browsing history found under $chrome_root" >&2
    rm -rf "$tmpdir"
    return 1
  fi

  # Build: ATTACH each DB as db0,db1,...; UNION ALL selects across them.
  attach_sql=""
  union_parts=()
  for (( i=1; i <= ${#copied_dbs[@]}; i++ )); do
    attach_sql+="attach database '${copied_dbs[i]}' as db${i};"$'\n'
    union_parts+=("select last_visit_time, title, url from db${i}.urls")
  done

  while true; do
    prompt='ch'
    (( exact_mode )) && prompt+=' [exact]'
    (( uniq_mode )) && prompt+=' [title-uniq]'
    prompt+='> '
    exact_label=off
    uniq_label=off
    (( exact_mode )) && exact_label=on
    (( uniq_mode )) && uniq_label=on
    header="F1: exact ${exact_label} | F2: title-uniq ${uniq_label}"

    fzf_opts=(
      --ansi
      --multi
      --no-sort
      --tiebreak=index
      --header-lines=1
      --print-query
      --expect=f1,f2
      --prompt "$prompt"
      --header "$header"
    )
    (( exact_mode )) && fzf_opts+=(--exact)
    [[ -n "$query" ]] && fzf_opts+=(--query "$query")

    output=$(
      sqlite3 -separator "$sep" "" \
        "${attach_sql}select datetime(last_visit_time / 1000000 - 11644473600, 'unixepoch', 'localtime'),
                coalesce(title, ''),
                url
         from (${(j: union all :)union_parts})
         order by last_visit_time desc" |
      awk -F "$sep" -v dc="$date_cols" -v tc="$title_cols" -v uniq="$uniq_mode" '
        BEGIN {
          printf "%-" dc "s  %-" tc "s  %s\n", "Visited At", "Title", "URL"
        }
        uniq && seen[$2]++ {
          next
        }
        {
          title = $2
          if (length(title) > tc) {
            title = substr(title, 1, tc)
          }
          printf "%-" dc "s  %-" tc "s  \x1b[36m%s\x1b[m\n", $1, title, $3
        }
      ' |
      fzf "${fzf_opts[@]}"
    ) || { rm -rf "$tmpdir"; return 0; }

    lines=("${(@f)output}")
    query="${lines[1]}"
    key="${lines[2]}"

    if [[ "$key" == "f1" ]]; then
      (( exact_mode = ! exact_mode ))
      continue
    fi
    if [[ "$key" == "f2" ]]; then
      (( uniq_mode = ! uniq_mode ))
      continue
    fi

    (( ${#lines[@]} < 3 )) && { rm -rf "$tmpdir"; return 0; }
    selections=("${lines[@][3,-1]}")
    urls=("${(@f)$(printf '%s\n' "${selections[@]}" | sed 's#.*\(https*://\)#\1#')}")

    for url in "${urls[@]}"; do
      "$opener" "$url" > /dev/null 2> /dev/null &
    done
    rm -rf "$tmpdir"
    return 0
  done
}

fzf-z-search() {
    local res=$(z | sort -rn | cut -c 12- | awk '!a[$0]++' | fzf --preview="ls -la {1}")
    if [ -n "$res" ]; then
        BUFFER="cd $res"
    fi
    zle accept-line
}

zle -N fzf-z-search
bindkey '^]' fzf-z-search

fzf-git-add() {
  local out n addfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ / /) print $2}' |
      fzf -m --exit-0 \
          --expect=enter \
          --preview="echo {} | xargs git diff --color" \
          --preview-window=right:50% \
          --header='Enter: add selected | Tab: toggle selection'); do

    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)

    [[ -z "$addfiles" ]] && continue
    git add "${addfiles[@]}"
  done
}

zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|ls)($| )" ]]
}

cd-gitroot() {
    cd ./$(git rev-parse --show-cdup)
}

if [[ -n "$SSH_CONNECTION" ]]; then
  pbcopy() {
    local input=$(cat)
    printf "\e]52;c;%s\a" "$(echo -n "$input" | base64)"
  }
fi

### End of Zinit's installer chunk

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# mise
eval "$(~/.local/bin/mise activate zsh)"
