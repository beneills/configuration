# 
# Aliases, some courtesy of Muflax
# 

# Emacs
alias e="emacsclient -c -n -a nano"
alias se="sudo -e"


# Youtube Download
function y() {
  # TODO convert to MP3
  echo "Paste links, ^D start to download."
  youtube-dl --ignore-errors --continue --rate-limit 2.5m -o "$HOME/youtube/%(title)s-%(id)s.%(ext)s" -a-
}

# Python
alias p2="python"
alias p3="python3"
alias p="python3"

# Move target to location and create symbolic link
function mvln() {
  mv $1 $2/ && ln -s $2/$1 $1
}

# A bit of security
alias cp="cp -i"
alias mv="mv -i"
