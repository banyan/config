# banyan's dotfiles

## Installation
```zsh
$ mkdir ~/git
$ git clone --recursive git://github.com/banyan/config ~/git/config
$ cd ~/git/config
$ rake dotfiles:setup -v noop=true # run as dry-run
$ rake dotfiles:setup -v force=true
```
