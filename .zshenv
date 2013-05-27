function _zshenv_add_path() {
    if [ -f /bin/grep ]; then
        grep=/bin/grep
    else
        grep=/usr/bin/grep
    fi

    _path=`eval echo \\$$1`

    if ! dirs=`eval echo $2 2>/dev/null`; then
        return
    fi

    reversed_dirs=
    for dir in `eval echo $dirs`; do
        reversed_dirs="$dir $reversed_dirs"
    done

    for dir in `eval echo $reversed_dirs`; do
        if [ ! -d $dir ]; then
            continue
        fi
        if echo $_path | $grep -Eq "(^|:)$dir($|:)"; then
            continue
        fi

        if [ "$_path" = "" ]; then
            eval _path=$dir
        elif [ "$3" = "before" ]; then
            eval _path=$dir:$_path
        else
            eval _path=$_path:$dir
        fi
    done

    eval $1=$_path
}

export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

export GIT_MERGE_AUTOEDIT=no

export PATH=
_zshenv_add_path PATH "$HOME/bin"
_zshenv_add_path PATH "$HOME/git/config/bin/*" # git で管理する bin
_zshenv_add_path PATH "$HOME/sbin"
_zshenv_add_path PATH "$HOME/node_modules/.bin"
_zshenv_add_path PATH "/usr/local/bin"
_zshenv_add_path PATH "/usr/local/sbin"
_zshenv_add_path PATH "/usr/local/*/bin"
_zshenv_add_path PATH "/usr/local/*/sbin"
_zshenv_add_path PATH "/opt/local/bin"
_zshenv_add_path PATH "/opt/local/sbin"
_zshenv_add_path PATH "/opt/local/*/bin"
_zshenv_add_path PATH "/opt/local/*/sbin"
_zshenv_add_path PATH "/opt/bin"
_zshenv_add_path PATH "/opt/sbin"
_zshenv_add_path PATH "/opt/*/bin"
_zshenv_add_path PATH "/opt/*/sbin"
_zshenv_add_path PATH "/bin"
_zshenv_add_path PATH "/sbin"
_zshenv_add_path PATH "/usr/bin"
_zshenv_add_path PATH "/usr/sbin"
_zshenv_add_path PATH "/usr/*/bin"
_zshenv_add_path PATH "/usr/*/sbin"
_zshenv_add_path PATH "/usr/local/lib/flex3/bin"
_zshenv_add_path PATH "/usr/local/src/apache-maven-2.2.1/bin"
_zshenv_add_path PATH "/usr/local/ImageMagick-6.5.8-5/lib"
_zshenv_add_path PATH "$HOME/perl5/lib/perl5"
_zshenv_add_path PATH "$HOME/.phpenv/bin"
_zshenv_add_path PATH "$HOME/.phpenv/shims"

export CPATH=
_zshenv_add_path CPATH "/usr/local/include"
_zshenv_add_path CPATH "/opt/local/include"
_zshenv_add_path CPATH "/opt/include"

#export JAVA_HOME=/usr/java/default
#export PATH=$PATH:$JAVA_HOME/bin
#export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar

#export JRUBY_HOME=/usr/local/lib/jruby
#export PATH=$JRUBY_HOME/bin:$PATH

# load local.zshenv
if [ -f "$HOME/.zsh.d/local.zshenv" ]; then
    source "$HOME/.zsh.d/local.zshenv"
fi
