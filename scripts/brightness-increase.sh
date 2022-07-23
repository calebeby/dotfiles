#/usr/bin/env bash

brightnessctl set +500;

# https://askubuntu.com/a/871207
notify-send "$(($(brightnessctl get) * 100 / $(brightnessctl max)))%" -h string:x-canonical-private-synchronous:brightnessval;
