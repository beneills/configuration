# reverse priority order
export PATH="/usr/local/bin:$PATH"
export PATH="/Users/ben/Library/Python/2.7/bin:$PATH"
export PATH="/Users/ben/files/bin:$PATH"

# python
export PYTHONPATH="$PYTHONPATH:~/files/repos/task-library"

# editor
export VISUAL="emacsclient -nw"
export EDITOR="$VISUAL"

# genestack aliases
alias gdeploy='fmvn package && genestack-application-manager install -o -s -S user v1 target/*.jar'

# speed up maven
export MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"

# multithreaded maven
alias fmvn="mvn -T 1C"

# terminal configuration
export CLICOLOR=1

# git aliases
alias g='git'
alias get='git'
alias ga='git add'
alias gm="git merge"
alias gs='git status'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias gsl="git shortlog -sn"
alias gw="git whatchanged"

# prompt
export PS1="\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]:\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
source /Users/ben/.oh-my-git/prompt.sh
