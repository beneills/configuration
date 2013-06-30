# Largely taken from: http://tldp.org/LDP/abs/html/sample-bashrc.html

## Exports
export MPD_HOST="192.168.1.67"

## Colours
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Purple='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'

BBlack='\e[1;30m'
BRed='\e[1;31m'
BGreen='\e[1;32m'
BYellow='\e[1;33m'
BBlue='\e[1;34m'
BPurple='\e[1;35m'
BCyan='\e[1;36m'
BWhite='\e[1;37m'

On_Black='\e[40m'
On_Red='\e[41m'
On_Green='\e[42m'
On_Yellow='\e[43m'
On_Blue='\e[44m'
On_Purple='\e[45m'
On_Cyan='\e[46m'
On_White='\e[47m'
NC="\e[m"

## Bash Options
set -o notify
set -o noclobber

shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob


## Env
PATH=~/bin:~/.secret/bin:$PATH
export EDITOR='emacsclient'


## Some aliases
alias e='$EDITOR'
alias g='source ~/.bashrc'
alias c='cd && clear'

# Aptitude
alias i='sudo aptitude install'
alias s='aptitude search'

# Typos
alias it='git'

alias off='sudo shutdown -h now'


alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

alias ..='cd ..'

alias du='du -h'    # Makes a more readable output.
alias df='df -Th'

alias ls='ls -h --color'
alias ll="ls -lv --group-directories-first"
alias la='ll -A'
alias tree='tree -Csuh'

## Pager
alias more='less'
export PAGER=less

## Some functions
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

## Completion

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    source /usr/share/bash-completion/bash_completion

# And Git completion
source ~/.bash/git-completion.bash

# Beeminder goals
if [ -f "/home/ziarkaen/.beeminder_goals" ]; then
    BEEMINDER_GOALS=$(tr '\n' ' ' < ~/.beeminder_goals);
fi
complete -W "$BEEMINDER_GOALS" beemind


# Multimedia
complete -f -o default -X \
    '!*.+(gif|GIF|jp*g|JP*G|bmp|BMP|xpm|XPM|png|PNG)' xv gimp ee gqview

complete -f -o default -X '!*.@(mp?(e)g|MP?(E)G|wma|avi|AVI|\
 asf|vob|VOB|bin|dat|vcd|ps|pes|fli|viv|rm|ram|yuv|mov|MOV|qt|\
 QT|wmv|mp3|MP3|ogg|OGG|ogm|OGM|mp4|MP4|wav|WAV|asx|ASX)' emms


function vpn() {
    sudo sh -c "echo \"nameserver 8.8.8.8\" > /etc/resolv.conf"
    sudo openvpn --config /etc/openvpn/myvpn.conf
}


# TODO
# alias h='history'
# alias j='jobs -l'
# alias which='type -a'
# alias lx='ls -lXB'         #  Sort by extension.
# alias lk='ls -lSr'         #  Sort by size, biggest last.
# alias lt='ls -ltr'         #  Sort by date, most recent last.
# alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
# alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# alias lm='ll |more'        #  Pipe through 'more'
# alias lr='ll -R'           #  Recursive ls.





