# banyan's .zshrc file
# Kohei Hasegawa <ameutau@gmail.com>
# https://github.com/banyan/config

# Complement
typeset -U fpath

# 履歴による予測入力 (man zshcontrib)
autoload -U predict-on

# 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)
zstyle ':completion:*:default' menu select=1
# 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補
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
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

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

fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
zinit cdreplay -q

ZSH_AUTO_ESCAPE_PREFIXES=('v' 'code' 'd' 'dic' 'git add' 'git co', 'mv', 'ls', 'ls -la', 'git ci')

# prompt
success_color=$'%{\e[38;5;38m%}'
failure_color=$'%{\e[38;5;227m%}'
path_color=$'%{\e[38;5;14m%}'
vcs_color=$'%{\e[38;5;248m%}'
stash_color=$'%{\e[38;5;226m%}'
firebase_color=$'%{\e[38;5;194m%}'
PROMPT_SYMBOL="❯"
PROMPT="%(?,%{$success_color%}${PROMPT_SYMBOL}%{$reset_color%},%{$failure_color%}${PROMPT_SYMBOL}%{$reset_color%}) "
VCS_INFO="%1(v|%{$vcs_color%}%1v%f%F%$reset_color{$stash_color%}%2v%f|)"
RPROMPT='%{$firebase_color%}$(firebase_project square)$reset_color${VCS_INFO}$path_color%}[%~]%{${reset_color}%}'

# Setup options
setopt APPEND_HISTORY         # .zsh_history を上書きではなく追加
setopt AUTO_CD                # ディレクトリ名だけを入力した時にそこに cd する
setopt AUTO_LIST              # 候補が複数ある時に自動的に一覧を出す
setopt AUTO_MENU              # TAB で順に補完候補を切り替える
setopt AUTO_PARAM_SLASH       # 変数名補完時に、その値がディレクトリ名なら直後にスラッシュも補う
setopt AUTO_PARAM_KEYS        # カッコの対応などを自動的に補完
setopt AUTO_RESUME            # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt CHECK_JOBS             # シェルを抜ける (exit) 時に、zsh: you have runnning jobs と警告を出す
setopt CORRECT                # コマンドのスペルチェック
setopt EXTENDED_GLOB          # ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt EXTENDED_HISTORY       # zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt GLOB_DOTS              # . で開始するファイル名にマッチさせるとき、先頭に明示的に . を指定する必要がなくなる。
setopt HASH_CMDS              # 各コマンドが実行されるときにパスをハッシュに入れる
setopt HIST_EXPIRE_DUPS_FIRST # ヒストリリストに追加されるコマンド行が古いものと同じなら古いものを削除する
setopt HIST_NO_STORE          # history コマンドを history に保存しない
setopt HIST_IGNORE_ALL_DUPS   # 履歴が重複した場合に古い履歴を削除する
setopt HIST_IGNORE_DUPS       # 直前と同じコマンドをヒストリに追加しない
setopt HIST_REDUCE_BLANKS     # 余分な空白は詰めて記録
setopt HIST_SAVE_NO_DUPS      # ヒストリファイルに書き出すときに、古いコマンドと同じものは無視する
setopt INC_APPEND_HISTORY     # 履歴をインクリメンタルに追加
setopt LIST_TYPES             # 補完候補一覧でファイルの種別をマーク表示
setopt MARK_DIRS              # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt NUMERIC_GLOB_SORT      # 数字を数値と解釈してソートする
setopt NOBEEP                 # ビープを鳴らさない
setopt NO_FLOW_CONTROL        # disable C-q, C-s
setopt PROMPT_SUBST           # PROMPT 変数に対して変数展開、コマンド置換、算術展開を施す
setopt SHARE_HISTORY          # 履歴の共有
setopt AUTOPUSHD              # cd 時に自動で push
setopt PUSHD_IGNORE_DUPS      # 同じディレクトリを pushd しない
setopt TRANSIENT_RPROMPT      # 現在のステータスの RPROMPT だけを表示する
unsetopt CORRECT_ALL          # 対象のファイルもスペルチェックをする

# Setup vars
export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export EDITOR=vim

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
alias f="ag_last_argument_then_peco_to_vim_all"
alias ff="ag_last_argument_then_peco_to_vim"
alias ttig='tig --follow'
alias tl='tldr'
alias cat='bat'
alias chrome='open -a "Google Chrome.app"'
alias tree='tree -N'
alias ag="ag --hidden"
alias v="vim"
alias u="cd-gitroot"

# terraform - use cargo-make to handle tfvars easily
alias ti='cargo make init'
alias tp='cargo make plan'
alias ta='cargo make apply'
alias ts='cargo make show'


# git
alias g="git"
alias dic='dc'
alias m="m"
alias b='git branch'
alias ai='aicommits'
alias k='vim -p `git modified_files`'
alias c='code `git modified_files`'
alias -g s='git st'
alias d='git diff'
alias A='fzf-git-add'
alias a='git add -A'
alias o='ghopen'
alias p="git p"
alias pr="gh pr create --web"
alias pl="git pl"
alias R="git reset"
alias -g G='| grep --color'
alias gm="git modified_files"
alias yo='git yo'
alias ran="git ran -e '^s|^a|^dic|^git|^ran'"

# for Mac
alias there="fcd"
alias here="open ."

# Keybindings
bindkey -e       # emacs 風
# カーソル位置から前方削除
# override kill-whole-line
bindkey '^U' backward-kill-line

# Misc
# コアダンプサイズを制限
limit coredumpsize 102400
# ls /usr/local/etc などと打っている際に、C-w で単語ごとに削除
# default  : ls /usr/local → ls /usr/ → ls /usr → ls /
# この設定 : ls /usr/local → ls /usr/ → ls /
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

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

# 256色を確かめる
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
  local default_branch=$(git default-branch)

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

function ag_last_argument_then_peco_to_vim() {
    last_command=$history[$[HISTCMD-1]];
    last_command_array=("${(s/ /)last_command}")
    vim `ag $@ $last_command_array[-1] | peco | awk -F : '{print "-c " $2 " " $1}'`
}

function ag_last_argument_then_peco_to_vim_all() {
    last_command=$history[$[HISTCMD-1]];
    last_command_array=("${(s/ /)last_command}")
    vim -p `ag -l $last_command_array[-1]`
}

function agv () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

ghopen() {
  file=$1
  base=$2

  if [ "$#" -eq 0 ]; then
    return `gh browse`
  fi

  gh="https://github.$(git config remote.origin.url | cut -f2 -d. | tr ':' /)"
  repo_name=`echo $gh | awk -F '/' 'END{print $NF}'` # get last field by using awk
  current_dir=${0:a:h} # get real dir name over symlink
  complementaly_path=`echo $current_dir | awk -F $repo_name 'END{print $NF}'`
  open "${gh}/blob/${base:=`git sha`}${complementaly_path}/${file}"
}

export FZF_DEFAULT_OPTS='--height 90% --layout=reverse --border -x --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up'
export FZF_DEFAULT_COMMAND='fd --type f'

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

function yarn-install () {
    local VERSION="${1}"
    if [ -z "${VERSION}" ]
    then
        curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
    else
        curl --compressed -o- -L https://yarnpkg.com/install.sh | bash -s -- --version "${VERSION}"
    fi
}

export FZF_CTRL_R_OPTS="--prompt=\"History > \""

# for node.js version manager
eval "`fnm env --multi --use-on-cd --log-level=quiet`" # for # https://github.com/Schniz/fnm

if [ -f "$HOME/.zsh.d/default-chruby" ]; then
    source "$HOME/.zsh.d/default-chruby"
fi

# opam configuration
test -r /Users/banyan/.opam/opam-init/init.zsh && . /Users/banyan/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

ch() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
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

tilex() {
    local count session="multirun"
    [[ -z $TMUX ]] && echo "No tmux, no bueno" && return
    echo

    while (($#)); do
        case $1 in
            --) shift; break ;;
            [0-9]*) count=$1; shift ;;
            *) echo "Usage: tilex <number> -- <command>"; return 1 ;;
        esac
    done

    [[ -z $count || $# -eq 0 ]] && {
        echo "Usage: tilex <number> -- <command>";
        return 1;
    }

    local cmd="$*"

    tmux new-window "$cmd"
    local target="."
    local created=1

    for ((i = created; i < count; i++)); do
        tmux split-window -t "$target" "$cmd" && ((created++))
    done

    tmux select-layout -t "$target" tiled
    tmux select-pane -t 0
}

