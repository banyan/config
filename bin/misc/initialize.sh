#!/bin/sh

# ~/git/config/ 以下で管理している dotfiles を $HOME にシンボリックリンクを貼る。
# なお、指定したリンクファイルがすでにあった場合は、上書きするかどうか問い合わせを行い、
# 上書きする場合には、.orig という suffix でファイルのバックアップを作成する。
echo "Make links for dotfiles"
find ~/git/config -maxdepth 1 -name '.*' -exec ln -sbi --suffix=.orig {} ~/ \;

# phpmanual を wget で取得して解凍、phpmanual に名前を変更する
echo "Get phpmanual and extract from tar"
cd ~/git/config/doc/
# wget -q で余分な出力を排除 O- で出力先を標準出力へ
wget -qO- http://jp2.php.net/get/php_manual_ja.tar.gz/from/jp.php.net/mirror | tar xof -
mv php-chunked-xhtml phpmanual

if [ $? -eq 0 ]; then
    echo "Successfully initialized... ;)"
else
    echo "some problems occur... O_o"
fi
