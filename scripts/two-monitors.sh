#!/bin/sh
xrandr --output DP1 --off
xrandr --output DP2 --off
xrandr --output HDMI2 --off
xrandr --output eDP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal
xrandr --output HDMI-1 --mode 1920x1080 --pos 3840x0 --rotate normal --scale 2x2 --auto --panning 2x2
xinput map-to-output $(xinput | rg Touchscreen | perl -ne 'while (m/id=(\d+)/g){print "$1\n";}') eDP-1
