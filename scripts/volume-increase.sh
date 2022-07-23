pactl set-sink-volume @DEFAULT_SINK@ +6%;

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,');

# https://askubuntu.com/a/871207
notify-send "$volume%" -h string:x-canonical-private-synchronous:volumeval;
