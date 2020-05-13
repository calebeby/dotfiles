#!/bin/sh
xrandr --output eDP-1 --primary --mode 3840x2160 --pos 624x360 --rotate normal --output HDMI-1 --off
xinput map-to-output $(xinput | rg Touchscreen | perl -ne 'while (m/id=(\d+)/g){print "$1\n";}') eDP-1
