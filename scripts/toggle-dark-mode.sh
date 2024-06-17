#!/usr/bin/env bash

THEME=$(gsettings get org.gnome.desktop.interface color-scheme)

# https://askubuntu.com/questions/769417/how-to-change-global-dark-theme-on-and-off-through-terminal

if [[ "$THEME" == "'prefer-dark'" ]]; then
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
else
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
fi

