#!/bin/sh --
set -e

echo
echo "make [proc.so|proc_cygwin.dll] for vimproc"
echo

case `uname -s` in
    Darwin)
        MAKE_FILE='make_mac.mak'
        PROC_FILE='proc.so'
        ;;
    Linux)
        MAKE_FILE='make_gcc.mak'
        PROC_FILE='proc.so'
        ;;
    FreeBSD)
        MAKE_FILE='make_gcc.mak'
        PROC_FILE='proc.so'
        ;;
    CYGWIN*)
        MAKE_FILE='make_cygwin.mak'
        PROC_FILE='proc_cygwin.dll'
        ;;
    *)
        echo "This type of OS is not supported"
        exit 1
        ;;
esac

cd ~/.vim/bundle/vimproc

if [ -f autoload/$PROC_FILE ]; then
    echo "deleting previous $PROC_FILE ..."
    rm autoload/$PROC_FILE
    echo "done"
    echo
fi

echo "compiling $PROC_FILE ..."
make -f $MAKE_FILE
echo "done"
echo

echo "vimproc: build success!"
echo
