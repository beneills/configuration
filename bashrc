# Largely taken from: http://tldp.org/LDP/abs/html/sample-bashrc.html

# OS default bashrc
[ -f ~/.bashrc_default ] && source ~/.bashrc_default

# Colours
source ~/.bash/colours.bash


## Load other config files
source ~/.bash/aliases.bash
source ~/.bash/completion.bash
source ~/.bash/env.bash
source ~/.bash/git-completion.bash
source ~/.bash/options.bash
source ~/.bash/inbox.bash
