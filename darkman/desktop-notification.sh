#!/usr/bin/env bash

MODE="$1"

case "$MODE" in
    dark)
        notify-send \
            --app-name="darkman" \
            --urgency=low \
            -t 500 \
            --icon=weather-clear-night \
            "switching to dark mode"
        ;;
    light)
        notify-send \
            --app-name="darkman" \
            --urgency=low \
            -t 500 \
            --icon=weather-clear \
            "switching to light mode"
        ;;
    *)
esac
