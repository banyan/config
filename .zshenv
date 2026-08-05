export GIT_MERGE_AUTOEDIT=no

# PATH is built zsh-natively: candidates are listed in priority order and the
# (N-/) glob qualifier drops anything that isn't an existing directory
# (symlinks followed) with plain stat calls — no subshells, no grep, no forks.
# typeset -U keeps the first occurrence and drops later duplicates.
typeset -U path
path=(
    $HOME/.local/share/mise/shims
    $HOME/bin
    /usr/local/bin
    /usr/local/sbin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /opt/X11/bin
    /bin
    /sbin
    /usr/bin
    /usr/sbin
    $HOME/.deno/bin
    /opt/homebrew/opt/openjdk@11/bin
    $HOME/.bun/bin
    $HOME/.local/bin
)
path=($^path(N-/))
export PATH

typeset -TU CPATH cpath
cpath=(/usr/local/include(N-/))
export CPATH

export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"

if (( $+commands[go] )); then
    export GOPATH=$HOME/go
    path+=($GOPATH/bin)
fi

# load local.zshenv
if [ -f "$HOME/.zsh.d/local.zshenv" ]; then
    source "$HOME/.zsh.d/local.zshenv"
fi
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
