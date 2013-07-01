#!/bin/sh

# Access my scripts
export PATH=~/bin:$PATH

# Tasks before anything else TODO: set up user anacron?
daily.sh >> /tmp/daily.log

# Autorun
chromium-browser &
emacs > /tmp/emacs.log &
anki &
keepassx &
terminator -m --title static_term & # static terminal
terminator -m --title fume_term -e fume & # fume

guake &
wicd-client --tray &
xscreensaver -no-splash &
xfce4-power-manager &
xfce4-volumed &
dropbox start &
clipboardd &

# and then the WM
exec awesome
