#!/bin/sh

# Autorun
chromium-browser &
emacs > /tmp/emacs.log &
anki &
keepassx &
terminator -m --title static_term & # static terminal
terminator -m --title fume_term -e fume & # fume

guake &
wicd-client &
xscreensaver -no-splash &
xfce4-power-manager &
xfce4-volumed &
dropbox start &

# and then the WM
exec awesome
