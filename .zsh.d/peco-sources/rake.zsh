function peco-rake-tasks() {
    local tasks="bundle exec rake -AT"
    task=$(eval $tasks | peco --query "$LBUFFER" )
    task_split=("${(s/ /)task}")
    BUFFER=$task_split[1,2]
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N peco-rake-tasks
