# banyan's .zshrc file
# Kohei Hasegawa <ameutau@gmail.com>
# https://github.com/banyan/config

# Complement
typeset -U fpath

autoload -U compinit
compinit -u

# 履歴による予測入力 (man zshcontrib)
autoload -U predict-on

# 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)
zstyle ':completion:*:default' menu select=1
# 補完の時に大文字小文字を区別しない (但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*' list-colors 'di=;00;38;05;44' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=00;38;05;44' 'cd=00;38;05;44'

# glob (*) での履歴のインクリメンタル検索
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# vcs_info
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"

    repo=`git rev-parse --show-toplevel`

    # http://stnard.jp/2010/10/25/402/
    if [[ -e $repo/.git/refs/stash ]]; then
        stashes=$(git stash list 2>/dev/null | wc -l)
        psvar[2]="[@${stashes// /}]"
    fi
}
add-zsh-hook precmd _update_vcs_info_msg

# plugins
if command -v antibody >/dev/null 2>&1
then
    # Fixes for oh-my-zsh, see https://github.com/getantibody/antibody/issues/218
    DISABLE_AUTO_UPDATE=true
    ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-banyan-SLASH-oh-my-zsh"

    source <(antibody init)
    antibody bundle < ~/.zsh.d/zsh_plugins.txt
else
    echo 'antibody is missing. install antibody'
fi

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
setopt RM_STAR_WAIT           # rm * を実行する前に確認
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

alias A='SITE_MODE=aya'

alias -g C='| pbcopy'
alias P='pbpaste'
alias l='ls -la'
alias wget='wget --no-check-certificate'
alias v="vi"
alias wcd="find ./ -type f | xargs wc -l"
alias diff='colordiff'
alias less='less -R'
alias sed='gsed'
alias tt='tmux new-session \; new-window \; new-window \; new-window \; new-window \; new-window \; new-window \; new-window'
alias pp='popd'
alias ocaml='rlwrap ocaml'
alias t='yarn test'
alias f="ag_last_argument_then_peco_to_vim_all"
alias ff="ag_last_argument_then_peco_to_vim"
alias ttig='tig --follow'

# rails
alias bundle='nocorrect bundle'
alias rspec='nocorrect rspec'
alias rspec='rspec -c'
alias be='bundle exec'
alias bi='bundle install --jobs 4'
alias rails-init='bundle install --path .bundle/gems && rake db:create db:migrate && powder link'
alias dbundle='ruby -I ~/git/bundler/lib ~/git/bundler/bin/bundle'

# git
alias g="git"
# alias ci="ciopen"
alias cia="git commit --amend"
alias pus="git push"
alias gw='git wtf'
alias gc='git clone --recursive'
alias ga="git add -p"
alias dic='dc'
alias m="m"
alias b='git branch'
alias k='vim -p `git modified`'
alias c='code `git modified`'
alias get='ghq get'
alias -g s='git st'
alias d='git diff'
alias a='git add -A'
alias o='ghopen'
alias p="git p"
alias pl="git pl"
alias -g G='| grep --color'
alias gm="git modified"
alias -g D='deis apps | peco'
alias yo='git yo'
alias ran="git ran -e '^s|^a|^dic|^git|^ran'"

alias ks='kubectl'

function kss() {
  ks config get-contexts | sed "/^\ /d"
  ks auth can-i get ns >/dev/null 2>&1 && echo "(Authorized)" || echo "(Unauthorized)"
}

function kc() {
  test "$1" = "-" && kubectx - || kubectx "$(kubectx | peco)"
}

function kn() {
  test "$1" = "-" && kubens - || kubens "$(kubens | peco)"
}

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
  git checkout `git default-branch`
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

# Peco
if [ `which peco >/dev/null 2>&1 ; echo $?` -eq 0 ]; then
  for f ($HOME/.zsh.d/peco-sources/*.zsh) source "${f}"

  bindkey '^r' peco-select-history
  bindkey '^g' peco-git-recent-branches
  bindkey '^s' peco-src

  alias -g H='$(hk apps | cut -d " " -f 1 | peco)'
  alias -g B='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
  alias -g K='vim $(`git status -s | cut -d " " -f 3 | peco`)'
fi


function ci() {
  local repo=`git config remote.origin.url | awk -F ':' '{ print $2 }' | awk -F '.' '{ print $1 }'`
  local branch=`git rev-parse --abbrev-ref HEAD`
  open "https://circleci.com/gh/${repo}/tree/${branch}"
}

ghopen() {
  file=$1
  base=$2

  if [ "$#" -eq 0 ]; then
    return `hub browse`
  fi

  gh="https://github.$(git config remote.origin.url | cut -f2 -d. | tr ':' /)"
  repo_name=`echo $gh | awk -F '/' 'END{print $NF}'` # get last field by using awk
  current_dir=${0:a:h} # get real dir name over symlink
  complementaly_path=`echo $current_dir | awk -F $repo_name 'END{print $NF}'`
  open "${gh}/blob/${base:=`git sha`}${complementaly_path}/${file}"
}

export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

lazynvm() {
  unset -f nvm node npm npx yarn
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
}

nvm() {
  lazynvm
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}

yarn() {
  lazynvm
  yarn $@
}

npx() {
  lazynvm
  npx $@
}

eval "$(exenv init -)"

if [ -f "$HOME/.zsh.d/default-chruby" ]; then
    source "$HOME/.zsh.d/default-chruby"
fi

# opam configuration
test -r /Users/banyan/.opam/opam-init/init.zsh && . /Users/banyan/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
