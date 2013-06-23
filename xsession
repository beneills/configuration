#!/bin/sh

# Autorun
guake &
chromium-browser &
emacs &
anki &
keepassx &
terminator --title static_term &
xscreensaver &
xfce4-power-manager &
xfce4-volumed &

# and then the WM
exec awesome


