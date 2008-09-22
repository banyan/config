export LANG=ja_JP.UTF-8
export TERM=xterm-256color
export LSCOLORS=cxfxcxdxbxegedabagacad

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

#  colors#  → 色指定  $fg[色名]/$bg[色名]/$reset_color (${, $} で囲む必要がある)
## 30黒 31赤 32緑 33黄 34青 35紫 36水 37白

#promptとか
local PROMPT_COLOR=$'%{\e[01;31m%}'
#local YELLOW_COLOR=$'%{\e[00;38;05;168%}'
#local RPROMPT_COLOR=$'%{\e[01;38;5;190%}'

#PROMPT=$PROMPT_COLOR'[${USER}@${HOSTNAME}] %(!.#.$) '
#RPROMPT=$RPROMPT_COLOR'[%~]'$DEFAULT
setopt PROMPT_SUBST

#http://coderepos.org/share/export/9486/dotfiles/zsh/mobcov/.zsh/.zshrc
autoload colors
colors
case ${UID} in
0)
    PROMPT="%{${fg[red]}%}${USER}@${fg[cyan]}${HOST%%.*}%(!.#.$)%{${reset_color}%}%b "
    RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%} "
    #PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    #PROMPT=$YELLOW_COLOR'[${USER}@${HOSTNAME}] %(!.#.$) '
    PROMPT2="%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    #[ -n "${USER}@${HOSTNAME}" ] &&
    #PROMPT="%{${fg[white]}%}$(echo ${HOST}@)${PROMPT}"
    #PROMPT="$YELLOW_COLOR$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
;;
*)
    PROMPT="%{${fg[red]}%}${USER}%(!.#.$)%{${reset_color}%} "
    RPROMPT="%{${fg[cyan]}%}[%~]%{${reset_color}%} "
    #PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    #PROMPT=$YELLOW_COLOR'[${USER}@${HOSTNAME}] %(!.#.$) '
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    #[ -n "${USER}@${HOSTNAME}" ] &&
    #PROMPT="%{${fg[white]}%}$(echo ${HOST}@)${PROMPT}"
    #PROMPT="$YELLOW_COLOR$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
;;
esac

##補完機能の強化
autoload -U compinit
compinit

### コアダンプサイズを制限
limit coredumpsize 102400
#
### 出力の文字列末尾に改行コードが無い場合でも表示
#unsetopt promptcr
#
### 色を使う
setopt prompt_subst
#
### ビープを鳴らさない
setopt nobeep
#
### 内部コマンド jobs の出力をデフォルトで jobs -l にする
#setopt long_list_jobs
#
### 補完候補一覧でファイルの種別をマーク表示
setopt list_types
#
### サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
#
### 補完候補を一覧表示
setopt auto_list
#
### 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
#
### cd 時に自動で push
#setopt autopushd
#
### 同じディレクトリを pushd しない
#setopt pushd_ignore_dups
#
### ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
#setopt extended_glob
#
### TAB で順に補完候補を切り替える
setopt auto_menu
#
### zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
#
### =command を command のパス名に展開する
#setopt equals
#
### --prefix=/usr などの = 以降も補完
#setopt magic_equal_subst
#
### ヒストリを呼び出してから実行する間に一旦編集
#setopt hist_verify
#
## ファイル名の展開で辞書順ではなく数値的にソート
#setopt numeric_glob_sort
#
### 出力時8ビットを通す
#setopt print_eight_bit
#
### ヒストリを共有
setopt share_history
#
### 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
#
### 補完候補の色づけ

autoload -U compinit
compinit

#zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;42'
#zstyle ':completion:*' list-colors ''

alias ls="ls -G"
alias gls="gls --color"
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=00;38;05;44:ln=01;35:so=01;32:ex=01;31:bd=00;38;05;44:cd=00;38;05;44:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=;00;38;05;44' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=00;38;05;44' 'cd=00;38;05;44'

autoload -U compinit
compinit

#export LSCOLORS=exfxcxdxbxegedabagacad
#export LS_COLORS='di=35:ln=35:so=32:pi=33:ex=31:bd=46;35:cd=43;35:su=41;30:sg=46;30:tw=42;30:ow=43;30'

#zstyle ':completion:*' list-colors 'di=35' 'ln=35' 'so=32' 'ex=31' 'bd=46;35' 'cd=43;35'

#export LSCOLORS=exfxcxdxbxegedabagacad
#export LS_COLORS='di=35:ln=35:so=32:pi=33:ex=31:bd=46;35:cd=43;35:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#zstyle ':completion:*' list-colors 'di=35' 'ln=35' 'so=32' 'ex=31' 'bd=46;35' 'cd=43;35'



### ディレクトリ名だけで cd
setopt auto_cd
#
### カッコの対応などを自動的に補完
setopt auto_param_keys
#
### ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
#setopt auto_param_slash
#
### スペルチェック
setopt correct

#alias
alias vi='vim'
alias ls="ls -G"
alias gls="gls --color"
alias ll='ls -l'

# disable C-q, C-s
setopt no_flow_control

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
  psa | head -n 1                                    # ラベルを表示
    psa | grep $* | grep -v "ps -auxww" | grep -v grep # grep プロセスを除外
}

# カーソル位置から前方削除
# override kill-whole-line
bindkey '^U' backward-kill-line

# ls /usr/local/etc などと打っている際に、C-w で単語ごとに削除
# default  : ls /usr/local → ls /usr/ → ls /usr → ls /
# この設定 : ls /usr/local → ls /usr/ → ls /
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

