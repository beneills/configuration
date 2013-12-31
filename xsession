#!/bin/bash

# Access my scripts
source ~/.bash/env.bash

# Daily Tasks
#(/home/ziarkaen/bin/daily.rb >> /tmp/daily.log) &

# TODO redshift
# TODO     /home/ziarkaen/bin/clipboardd &

# Autorun
#chromium-browser &
#emacs &
#guake &
#wicd-client --tray &

# delayed
#(sleep 5; \
#    anki -l fr & \
#    keepassx & \
#    terminator -m --title static_term & \
#    terminator -m --title fume_term -e fume_ben & \
#    terminator -m --title linode_term -e "ssh linode" & \
#    xscreensaver -no-splash & \
#    xfce4-power-manager & \
#    xfce4-volumed & \
#    dropbox start & \
#    google-musicmanager & \
#    jekyll serve --watch -s ~/projects/beneills.com &) &
#    xflock4 &) &
    
# and then the WM
exec awesome
