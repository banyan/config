#!/bin/sh

# ~/git/config/ 以下で管理している dotfiles を $HOME にシンボリックリンクを貼る。
# なお、指定したリンクファイルがすでにあった場合は、上書きするかどうか問い合わせを行い、
# 上書きする場合には、.orig という suffix でファイルのバックアップを作成する。
find ~/git/config -maxdepth 1 -name '.*' -exec ln -sbi --suffix=.orig {} ~/ \;
