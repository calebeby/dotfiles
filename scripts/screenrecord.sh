#!/bin/sh

# based on
# https://github.com/swaywm/sway/blob/master/contrib/grimshot
# but modified to record a video instead

getTargetDirectory() {
  echo "$HOME/Screenshots";
  # test -f "${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs" && \
  #   . "${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs"

  # echo "${XDG_SCREENSHOTS_DIR:-${XDG_PICTURES_DIR:-$HOME}}"
}

NOTIFY=no

while [ $# -gt 0 ]; do
  key="$1"

  case $key in
    -n|--notify)
      NOTIFY=yes
      shift # past argument
      ;;
    *)    # unknown option
      break # done with parsing --flags
      ;;
  esac
done

ACTION=${1:-usage}
SUBJECT=${2:-screen}
FILE=${3:-$(getTargetDirectory)/$(date -Ins).mp4}

if [ "$ACTION" != "save" ] && [ "$ACTION" != "check" ]; then
  echo "Usage:"
  echo "  screenrecord [--notify] (save) [active|screen|output|area|window] [FILE|-]"
  echo "  screenrecord check"
  echo "  screenrecord usage"
  echo ""
  echo "Commands:"
  echo "  save: Save the screenshot to a regular file or '-' to pipe to STDOUT."
  echo "  check: Verify if required tools are installed and exit."
  echo "  usage: Show this message and exit."
  echo ""
  echo "Targets:"
  echo "  active: Currently active window."
  echo "  screen: All visible outputs."
  echo "  output: Currently active output."
  echo "  area: Manually select a region."
  echo "  window: Manually select a window."
  exit
fi

notify() {
  notify-send -t 3000 -a screenrecord "$@"
}
notifyOk() {
  [ "$NOTIFY" = "no" ] && return

  TITLE=${2:-"Screenshot"}
  MESSAGE=${1:-"OK"}
  notify "$TITLE" "$MESSAGE"
}
notifyError() {
  if [ $NOTIFY = "yes" ]; then
    TITLE=${2:-"Screenshot"}
    MESSAGE=${1:-"Error taking video recording with wf-recorder"}
    notify -u critical "$TITLE" "$MESSAGE"
  else
    echo "$1"
  fi
}

die() {
  MSG=${1:-Bye}
  notifyError "Error: $MSG"
  exit 2
}

check() {
  COMMAND=$1
  if command -v "$COMMAND" > /dev/null 2>&1; then
    RESULT="OK"
  else
    RESULT="NOT FOUND"
  fi
  echo "   $COMMAND: $RESULT"
}

takeScreencast() {
  FILE=$1
  GEOM=$2
  OUTPUT=$3
  if [ -n "$OUTPUT" ]; then
    wf-recorder -f "$OUTPUT" "$FILE" || die "Unable to invoke wf-recorder" &
    PID=$!
  elif [ -z "$GEOM" ]; then
    wf-recorder -f "$FILE" || die "Unable to invoke wf-recorder" &
    PID=$!
  else
    wf-recorder -g "$GEOM" -f "$FILE" || die "Unable to invoke wf-recorder" &
    PID=$!
  fi
  while read -n1 char ; do
    if [ "$char" = "q" ] ; then
      kill "$PID"
      break
    fi
  done
}

if [ "$ACTION" = "check" ] ; then
  echo "Checking if required tools are installed. If something is missing, install it to your system and make it available in PATH..."
  check wf-recorder
  check slurp
  check swaymsg
  check jq
  check notify-send
  exit
elif [ "$SUBJECT" = "area" ] ; then
  GEOM=$(slurp -d)
  # Check if user exited slurp without selecting the area
  if [ -z "$GEOM" ]; then
    exit 1
  fi
  WHAT="Area"
elif [ "$SUBJECT" = "active" ] ; then
  FOCUSED=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?, .floating_nodes[]?) | select(.focused)')
  GEOM=$(echo "$FOCUSED" | jq -r '.rect | "\(.x),\(.y) \(.width)x\(.height)"')
  APP_ID=$(echo "$FOCUSED" | jq -r '.app_id')
  WHAT="$APP_ID window"
elif [ "$SUBJECT" = "screen" ] ; then
  GEOM=""
  WHAT="Screen"
elif [ "$SUBJECT" = "output" ] ; then
  GEOM=""
  OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused)' | jq -r '.name')
  WHAT="$OUTPUT"
elif [ "$SUBJECT" = "window" ] ; then
  GEOM=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
  # Check if user exited slurp without selecting the area
  if [ -z "$GEOM" ]; then
   exit 1
  fi
  WHAT="Window"
else
  die "Unknown subject to take a screen shot from" "$SUBJECT"
fi

if takeScreencast "$FILE" "$GEOM" "$OUTPUT"; then
  TITLE="Screenshot of $SUBJECT"
  MESSAGE=$(basename "$FILE")
  notifyOk "$MESSAGE" "$TITLE"
  echo "$FILE"
else
  notifyError "Error taking video recording with wf-recorder"
fi
