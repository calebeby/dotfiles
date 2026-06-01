#!/usr/bin/env bash

MODE="$1"

case "$MODE" in
    dark)
        # Update system theme and color scheme for dark mode
        gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        ;;
    light)
        # Update system theme and color scheme for light mode
        gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        ;;
    *)
esac
