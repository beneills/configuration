#!/bin/sh

# Autorun
chromium-browser &
emacs &
anki &
keepassx &
terminator --title static_term & # static terminal
terminator --title fume_term -e fume & # fume

guake &
xscreensaver -no-splash &
xfce4-power-manager &
xfce4-volumed &
dropbox start &

# and then the WM
exec awesome
