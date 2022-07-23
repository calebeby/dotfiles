brightnessctl set 250- --min-value 1;

# https://askubuntu.com/a/871207
notify-send "$(($(brightnessctl get) * 100 / $(brightnessctl max)))%" -h string:x-canonical-private-synchronous:brightnessval;
