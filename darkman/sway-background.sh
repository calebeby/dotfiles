#!/usr/bin/env bash

MODE="$1"

case "$MODE" in
    dark)
        swaymsg "output * bg ~/dotfiles/wallpapers/stars.jpg fill"
        ;;
    light)
        swaymsg "output * bg ~/dotfiles/wallpapers/lake.jpg fill"
        ;;
    *)
        ;;
esac
