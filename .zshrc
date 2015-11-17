# banyan's .zshrc file
# Kohei Hasegawa <ameutau@gmail.com>
# https://github.com/banyan/config

# Complement {{{
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

# 補完関数を作成する時のデバッグ用関数
# if [ -f "$HOME/.zsh/debug.zshrc" ]; then
    # source "$HOME/.zsh/debug.zshrc"
# fi

# vcs_info
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:bzr:*' use-simple true

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"

    # http://stnard.jp/2010/10/25/402/
    if [[ -e $PWD/.git/refs/stash ]]; then
        stashes=$(git stash list 2>/dev/null | wc -l)
        psvar[2]="[@${stashes// /}]"
    fi
}
add-zsh-hook precmd _update_vcs_info_msg

# source git-escape-magic
if [ -f "$HOME/.zsh.d/git-escape-magic" ]; then
    source "$HOME/.zsh.d/git-escape-magic"
    autoload -Uz git-escape-magic
    git-escape-magic
fi

# load antigen
if [ -f "$HOME/.zsh.d/antigen/antigen.zsh" ]; then
    source "$HOME/.zsh.d/antigen/antigen.zsh"
fi
# }}}

# Autoload zsh modules when they are referenced {{{
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile
# }}}

# Settings for antigen {{{
antigen bundle git
antigen bundle command-not-found

# antigen theme banyan/oh-my-zsh themes/fox
antigen theme banyan/oh-my-zsh themes/banyan

antigen apply
# }}}

# Setup options {{{
setopt APPEND_HISTORY         # .zsh-history を上書きではなく追加
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

#setopt EQUALS                # =command を command のパス名に展開する
#setopt HIST_VERIFY           # ヒストリを呼び出してから実行する間に一旦編集
#setopt LIST_ROWS_FIRST       # 補完リストを水平にソートする
#setopt LONG_LIST_JOBS        # 内部コマンド jobs の出力をデフォルトで jobs -l にする
#setopt MAGIC_EQUAL_SUBST     # --prefix=/usr などの = 以降も補完
#setopt PRINT_EIGHT_BIT       # 出力時8ビットを通す

#unsetopt PROMPTCR            # 出力の文字列末尾に改行コードが無い場合でも表示
# }}}

# Setup vars {{{
export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export EDITOR=vim

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
REPORTTIME=3
# Use dircolors where available
# export LS_COLORS='no=00:di=00;38;05;44:ln=01;35:pi=33:so=01;32:bd=00;38;05;44:cd=00;38;05;44:ex=01;32:*.c=36:*.cc=36:*.h=33:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.app=01;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.sit=00;31:*.sitX=00;31:*.zip=00;31:*.bin=00;31:*.hqx=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.pdf=00;35:*.avi=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.asf=00;35:*.wmv=00;35:*.rm=00;35:*.swf=00;35:*.mp3=00;35:*.aiff=00;35:*.aif=00;35:*.snd=00;35:*.wav=00;35:';
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors \
    'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# export ZLS_COLORS=$LS_COLORS
# }}}

# Aliases {{{
case "$OSTYPE" in
    freebsd*|darwin*)
        alias ls='ls -G -w'
    ;;
    *)
        alias ls='ls --color=auto'
    ;;
esac

alias -g C='| pbcopy'
alias P='pbpaste'
alias ll='ls -la'
alias lla='ls -A'
alias l='ll'
alias wget='wget --no-check-certificate'
alias p="popd"
alias v="vi"
alias wcd="find ./ -type f | xargs wc -l"
alias diff='colordiff'
alias less='less -R'
alias sed='gsed'
alias tt='tmux'
alias pp='pending-pr'
alias node='node --harmony'
alias ocaml='rlwrap ocaml'
alias t='npm test'
alias f="ag_last_argument_then_peco_to_vim_all"
alias ff="ag_last_argument_then_peco_to_vim"

# rails
alias r="rails"
alias bundle='nocorrect bundle'
alias rspec='nocorrect rspec'
alias rr="routes_cache | peco"
alias rrg="routes_cache | grep"
alias rrr="routes_cache --force | peco"
alias rspec='rspec -c'
alias be='bundle exec'
alias bi='bundle install --jobs 4'
alias rails-init='bundle install --path .bundle/gems && rake db:create db:migrate && powder link'
alias dbundle='ruby -I ~/git/bundler/lib ~/git/bundler/bin/bundle'

# Vagrant
alias vg="vagrant"

# brunch
alias bb='brunch build'
alias bbs='brunch watch --server'
alias bbm='brunch build && mocha-phantomjs public/test/index.html'
alias br='be rake run'

# git
alias g="git"
alias ci="git commit"
alias cia="git commit --amend"
alias gl="pull_default_branch"
alias pus="git push"
alias gw='git wtf'
alias gc='git clone --recursive'
alias ga="git add -p"
alias dic='dc'
alias m="checkout_default_branch"
alias b='git branch'
alias k='vim -p `git modified`'
alias get='ghq get'
alias s='git st'
alias d='git diff'
alias a='git add -A'
alias o='hub browse'
alias -g G='| grep --color'
alias gm="git modified"

# function my_function() {
    # # やりたい処理
    # # キー実行時のプロンプトの内容は $BUFFER で取れる
 # }
# zle -N vp  # my_functionをwidgetとして登録
# bindkey '^k' vp # my_functionをCtrl-Aにバインド

bindkey '^f' vp

# grep や ack で絞り込んだ結果を vim で開く
# http://subtech.g.hatena.ne.jp/secondlife/20100819/1282200855
alias -g V="| vim -"

# for Mac
alias there="fcd"
alias here="open ."
# }}}

# Keybindings {{{
bindkey -e       # emacs 風
# bindkey -v     # vi 風
# カーソル位置から前方削除
# override kill-whole-line
bindkey '^U' backward-kill-line
# }}}

# Misc {{{
# コアダンプサイズを制限
limit coredumpsize 102400
# ls /usr/local/etc などと打っている際に、C-w で単語ごとに削除
# default  : ls /usr/local → ls /usr/ → ls /usr → ls /
# この設定 : ls /usr/local → ls /usr/ → ls /
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# added by travis gem
[ -f /Users/banyan/.travis/travis.sh ] && source /Users/banyan/.travis/travis.sh
# }}}

# Misc {{{

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

# cache for rake routes
function routes_cache {
    local routes_cache; routes_cache="./tmp/routes_cache"
    if [ "$1" = "--force" ]; then
        rm $routes_cache;
    fi
    if ! [ -e $routes_cache ]; then
        bundle exec rake routes > $routes_cache
    fi
    cat $routes_cache
}

function rake_tasks_cache {
    local rake_tasks_cache; rake_tasks_cache="./tmp/rake_tasks_cache"
    if [ "$1" = "--force" ]; then
        rm $rake_tasks_cache;
    fi
    if ! [ -e $rake_tasks_cache ]; then
        bundle exec rake -AT > $rake_tasks_cache
    fi
    # cat $rake_taskes_cache

    task=$(cat $rake_tasks_cache | peco --query "$LBUFFER" )
    task_split=("${(s/ /)task}")
    BUFFER=$task_split[1,2]
    CURSOR=$#BUFFER
    zle -R -c
}

function spork_process {
}

function checkout_default_branch () {
    if [ `git show-ref --verify --quiet refs/heads/develop >/dev/null 2>&1 ; echo $?` -eq 0 ]
    then
        git checkout develop
    else
        git checkout master
    fi
}

function pull_default_branch () {
    if [ `git show-ref --verify --quiet refs/heads/develop >/dev/null 2>&1 ; echo $?` -eq 0 ]
    then
        git pull origin develop
    else
        git pull origin master
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

# Peco
if [ `which peco >/dev/null 2>&1 ; echo $?` -eq 0 ]; then
  for f ($HOME/.zsh.d/peco-sources/*.zsh) source "${f}"

  bindkey '^r' peco-select-history
  bindkey '^g' peco-git-recent-branches
  bindkey '^s' peco-src

  alias T='peco-rake-tasks'
  alias R='peco-rake-routes'
  alias -g H='$(hk apps | cut -d " " -f 1 | peco)'
  alias -g B='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
  alias -g K='vim $(`git status -s | cut -d " " -f 3 | peco`)'
fi
# }}}
