# banyan's dotfiles

## Setup

```zsh
mkdir -p ~/git
git clone https://github.com/banyan/config ~/git/config
cd ~/git/config
git submodule update --init --recursive

# Symlink dotfiles into $HOME
mise run setup

# Optional
mise run install:nvim
mise run install:ghostty
mise run deno-scripts
```

## Notes

- This repo is zsh-first (`.zshenv`, `.zshrc`).
