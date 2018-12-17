#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 3840x2160 --pos 624x360 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --off
xinput map-to-output $(xinput | rg Touchscreen | perl -ne 'while (m/id=(\d+)/g){print "$1\n";}') eDP1
