# 補完関数デバッグ用
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

r() {
  local f
  f=(~/.zsh/myfunc/*(.))
  unfunction $f:t 2> /dev/null
  autoload -U $f:t
}

