#!/usr/bin/env fish

set -l output '{ "version": 1 }'

echo $output
echo '['

function get_time -d "retrieves the current time"
  set -l time (date '+%-I:%M %a, %b %-d')
  set -l hour (date '+%-I')
  if [ "$hour" = 12 ]
    echo "🕛"
  else if [ "$hour" = 1 ]
    echo "🕐"
  else if [ "$hour" = 2 ]
    echo "🕑"
  else if [ "$hour" = 3 ]
    echo "🕒"
  else if [ "$hour" = 4 ]
    echo "🕓"
  else if [ "$hour" = 5 ]
    echo "🕔"
  else if [ "$hour" = 6 ]
    echo "🕕"
  else if [ "$hour" = 7 ]
    echo "🕖"
  else if [ "$hour" = 8 ]
    echo "🕗"
  else if [ "$hour" = 9 ]
    echo "🕘"
  else if [ "$hour" = 10 ]
    echo "🕙"
  else if [ "$hour" = 11 ]
    echo "🕚"
  end
  echo " $time"
end

function get_battery -d "gets the current battery level"
  if string match -r "Discharging" (acpi) > /dev/null
    echo "⚡"
  else if string match -r "Charging" (acpi) > /dev/null
    echo "🔌"
  else if string match -r "Full" (acpi) > /dev/null
    echo "✔️"
  end
  string match -r "[0-9]*%" (acpi)
end

while true
  set -l time (get_time)
  set -l battery (get_battery)
  echo "  [
    {
      \"full_text\": \"$time\"
    },
    {
      \"full_text\": \"$battery\"
    }
  ],"

  sleep 10
end
