###
# Complement
###
typeset -U fpath
fpath=($fpath ~/.zsh/myfunc)

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

# 補完関数を作成する時のデバッグ用関数
if [ -f "$HOME/.zsh/debug.zshrc" ]; then
    # source "$HOME/.zsh/debug.zshrc"
fi

###
# Autoload zsh modules when they are referenced
###
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

###
# Prompts
###
# colors#  → 色指定  $fg[色名]/$bg[色名]/$reset_color (${, $} で囲む必要がある)
# 30黒 31赤 32緑 33黄 34青 35紫 36水 37白
# http://coderepos.org/share/export/9486/dotfiles/zsh/mobcov/.zsh/.zshrc
autoload colors
colors
PROMPT="%{${fg[red]}%}${USER}%(!.#.$)%{${reset_color}%} "
RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%} "
PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
PROMPT="%{${fg[yellow]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"

###
# Setup options
###
setopt APPEND_HISTORY         # .zsh-history を上書きではなく追加
setopt AUTO_CD                # ディレクトリ名だけを入力した時にそこに cd する
setopt AUTO_LIST              # 候補が複数ある時に自動的に一覧を出す
setopt AUTO_MENU              # TAB で順に補完候補を切り替える
setopt AUTO_PARAM_SLASH       # 変数名補完時に、その値がディレクトリ名なら直後にスラッシュも補う
setopt AUTO_PARAM_KEYS        # カッコの対応などを自動的に補完
setopt AUTO_RESUME            # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt CHECK_JOBS             # シェルを抜ける (exit) 時に、zsh: you have runnning jobs と警告を出す
setopt CORRECT                # コマンドのスペルチェック
setopt CORRECT_ALL            # 対象のファイルもスペルチェックをする
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

#setopt AUTOPUSHD             # cd 時に自動で push
#setopt EQUALS                # =command を command のパス名に展開する
#setopt HIST_VERIFY           # ヒストリを呼び出してから実行する間に一旦編集
#setopt LIST_ROWS_FIRST       # 補完リストを水平にソートする
#setopt LONG_LIST_JOBS        # 内部コマンド jobs の出力をデフォルトで jobs -l にする
#setopt MAGIC_EQUAL_SUBST     # --prefix=/usr などの = 以降も補完
#setopt PRINT_EIGHT_BIT       # 出力時8ビットを通す
#setopt PUSHD_IGNORE_DUPS     # 同じディレクトリを pushd しない

#unsetopt PROMPTCR            # 出力の文字列末尾に改行コードが無い場合でも表示

###
# Setup vars
###
export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export EDITOR=vim

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=00;38;05;44:ln=01;35:so=01;32:ex=01;31:bd=00;38;05;44:cd=00;38;05;44:su=41;30:sg=46;30:tw=42;30:ow=43;30'

###
# Aliases
###
alias ls="ls --color=auto"
alias lla='ls -A'

#alias vi='vim'

###
# Keybindings
###
bindkey -e       # emacs 風
# bindkey -v     # vi 風
# カーソル位置から前方削除
zstyle ':completion:*' list-colors 'di=;00;38;05;44' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=00;38;05;44' 'cd=00;38;05;44'
# override kill-whole-line
bindkey '^U' backward-kill-line


###
# Misc
###
# コアダンプサイズを制限
limit coredumpsize 102400
# ls /usr/local/etc などと打っている際に、C-w で単語ごとに削除
# default  : ls /usr/local → ls /usr/ → ls /usr → ls /
# この設定 : ls /usr/local → ls /usr/ → ls /
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#source $HOME/.zsh.d/dirctx

###
# Functions
###

# svn st, git st
function s() {
    local -A result
    result=`git status 2> /dev/null`
    if [ "$result" ] ; then
        echo $result
        return
    fi
    svn status
}

# svn di, git di
function d() {
    local opt
    local -A result
    opt=$*
    result=`git status 2> /dev/null`

    if [ "$result" ] ; then
        git diff $opt | diffcolor.rb | /usr/bin/less -RE
        return
    fi
    svn di $opt | diffcolor.rb | /usr/bin/less -RE
}

# svn add, git add
function a() {
    local -A result
    result=`git status 2> /dev/null`
    if [ "$result" ] ; then
        git add .
        return
    fi
    svn status | grep '^?' | awk '{print $2}' | xargs svn add
}

# svn up, git pull origin master
function u() {
    result=`git status 2> /dev/null`
    if [ "$result" ] ; then
        git pull origin master
        return
    fi
    svn up
}

# start screen from given directory
function sc(){
    cd $1
    screen
}

# find out what's new in a directory:
function lsn() {
    ls -lt ${1+"$@"} | head -20;
}

# http://d.hatena.ne.jp/aircastle/20080428

# CPU 使用率の高い方から8つ
function pst() {
  psa | head -n 1
    psa | sort -r -n +2 | grep -v "ps -auxww" | grep -v grep | head -n 8
}

# メモリ占有率の高い方から8つ
function psm() {
  psa | head -n 1
    psa | sort -r -n +3 | grep -v "ps -auxww" | grep -v grep | head -n 8
}

# 全プロセスから引数の文字列を含むものを grep
function psg() {
  psa | head -n 1                                      # ラベルを表示
    psa | grep $* | grep -v "ps -auxww" | grep -v grep # grep プロセスを除外
}

# http://subtech.g.hatena.ne.jp/secondlife/20080604/1212562182
function cdf () {
    local -a tmpparent; tmpparent=""
    local -a filename; filename="${1}"
    local -a file
    local -a num; num=0
    while [ $num -le 10 ]; do
        tmpparent="${tmpparent}../"
        file="${tmpparent}${filename}"
        if [ -f "${file}" ] || [ -d "${file}" ]; then
            cd ${tmpparent}
            break
        fi
        num=$(($num + 1))
    done
}
function cdrake () {
    cdf "Rakefile"
}

function cdcat () {
    cdf "Makefile.PL"
}

