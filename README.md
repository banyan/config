# banyan's dotfiles

## Setup

```zsh
mkdir -p ~/git
git clone https://github.com/banyan/config ~/git/config
cd ~/git/config
git submodule update --init --recursive

# Run all setup tasks (dotfiles, nvim, ghostty, deno)
mise run setup
```

### Individual tasks

| Task | Description |
|------|-------------|
| `mise run install:dotfiles` | Symlink dotfiles into `$HOME` |
| `mise run install:nvim` | Install neovim and symlink `~/.config/nvim` |
| `mise run install:ghostty` | Symlink `~/.config/ghostty` |
| `mise run deno-scripts` | Install deno global scripts |
| `mise run cleanup` | Remove orphaned symlinks |

## Notes

- This repo is zsh-first (`.zshenv`, `.zshrc`).
