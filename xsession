#!/bin/bash

# Access my scripts
source ~/.bash/env.bash

# Tasks before anything else TODO: set up user anacron?
DAILY="/home/ziarkaen/bin/daily.rb"
($DAILY >> /tmp/daily.log; emacs) &

# TODO redshift

# Autorun
chromium-browser &
anki -l fr &
keepassx &
terminator -m --title static_term & # static terminal
terminator -m --title fume_term -e fume_ben & # fume

guake &
wicd-client --tray &
xscreensaver -no-splash &
xfce4-power-manager &
xfce4-volumed &
dropbox start &
/home/ziarkaen/bin/clipboardd &

# and then the WM
exec awesome
