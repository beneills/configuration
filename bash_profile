if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

##
# Your previous /Users/ben/.bash_profile file was backed up as /Users/ben/.bash_profile.macports-saved_2017-03-03_at_12:28:00
##

# MacPorts Installer addition on 2017-03-03_at_12:28:00: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# added by Anaconda3 4.3.1 installer
#export PATH="/Users/ben/anaconda/bin:$PATH"
