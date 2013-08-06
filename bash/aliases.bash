## Some aliases

alias log='~/projects/log/log.rb'
alias cinema='echo "Ctrl-C to exit"; watch -n10 "xscreensaver-command -deactivate" > /dev/null'
# Editor
alias e='_e'
# Editor Light
alias el='emacsclient -nw'

alias g='source ~/.bashrc'
alias c='cd && clear'

# Aptitude
alias i='sudo aptitude install'
alias s='aptitude search'

alias gi='sudo gem install'

# Stretches
alias football1='stretches -f ~/.stretches/football1.yaml'

alias anki-french='anki-french.rb -f ~/Anki/cloze-imports.txt'

# Typos
alias it='git'

alias off='sudo shutdown -h now'
alias gh='hub browse'
alias archive='mv -int ~/archive'
alias less='less -i'
alias po='popd'
alias grep='grep -i'


alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias ..='cd ..'

alias du='du -h'    # Makes a more readable output.
alias df='df -Th'

alias ls='ls -h --color=always --group-directories-first -v'
alias ll="ls -lv --group-directories-first"
alias la='ll -A'
alias tree='tree -Csuh'

## Pager
alias more='less'
export PAGER=less

## Some functions
# Editor: edit file in some existing frame, focus and return focus
# TODO: Check for X
function _e() {
    # Current 'desktop' (= awesome tag of lowest index)
     CUR=`wmctrl -d | grep -e " \* " | cut -f1 -d' '`
     wmctrl -a "emacs@"
     emacsclient $@
     wmctrl -s $CUR
}




# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Swap 2 filenames around, if they exist (from Uzi's bashrc).
function swap()
{ 
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# Handy Extract Program
function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Play directory
function emms() {
    if [ -z "$1" ]; then
	TARGET="$(dirname "$0")"
    else
	TARGET=$1
    fi
    if [ -d "$TARGET" ]; then
	CMD="emms-play-directory-tree"
    else
	CMD="emms-play-file"
    fi
    (emacsclient -e "($CMD \"$TARGET\")" || echo >&2 ) > /dev/null
}

function vpn() {
    sudo sh -c "echo \"nameserver 8.8.8.8\" > /etc/resolv.conf"
    sudo openvpn --config /etc/openvpn/myvpn.conf
}

