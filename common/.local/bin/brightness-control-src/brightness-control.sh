#!/usr/bin/env bash

IDFILE="/tmp/brightness_notify_id"
PREVFILE="/tmp/brightness_prev_value"

# Print error message for invalid arguments
print_error() {
  cat <<"EOF"
Usage: ./brightnesscontrol.sh -o <action>
Valid actions are:
    i -- <i>ncrease brightness [+2%]
    d -- <d>ecrease brightness [-2%]
EOF
}

# Determine icon based on brightness level
get_icon() {
  if ((brightness <= 5)); then
    ICON=""
  elif ((brightness <= 15)); then
    ICON=""
  elif ((brightness <= 30)); then
    ICON=""
  elif ((brightness <= 45)); then
    ICON=""
  elif ((brightness <= 55)); then
    ICON=""
  elif ((brightness <= 65)); then
    ICON=""
  elif ((brightness <= 80)); then
    ICON=""
  elif ((brightness <= 95)); then
    ICON=""
  else
    ICON=""
  fi
}

# Get the current brightness percentage and device name
get_brightness() {
  brightness=$(brightnessctl -m | grep -o '[0-9]\+%' | head -c-2)
  device=$(brightnessctl -m | head -n 1 | awk -F',' '{print $1}' | sed 's/_/ /g; s/\<./\U&/g')
  current_brightness=$(brightnessctl -m | head -n 1 | awk -F',' '{print $3}')
  max_brightness=$(brightnessctl -m | head -n 1 | awk -F',' '{print $5}')
}

# Send a notification with brightness info and persistent ID
send_notification() {
  get_icon
  # Load notification ID
  if [ -f "$IDFILE" ]; then
    ID=$(cat "$IDFILE")
    [[ -z "$ID" ]] && ID=0
  else
    ID=0
  fi

  # Show notification and store new ID
  NEW_ID=$(notify-send -a "state" "$ICON ${brightness}%" -h int:value:"$brightness" -u low --replace-id=$ID --print-id --app-name="Brightness")
  echo "$NEW_ID" > "$IDFILE"
}

# Save current brightness level to track changes
save_prev_brightness() {
  echo "$brightness" > "$PREVFILE"
}

get_brightness

# Handle options
while getopts o: opt; do
  case "${opt}" in
  o)
    case $OPTARG in
    i) # Increase brightness
      if [[ $brightness -lt 10 ]]; then
        brightnessctl set +1%
      else
        brightnessctl set +2%
      fi
      get_brightness
      send_notification
      save_prev_brightness
      ;;
    d) # Decrease brightness
      if [[ $brightness -le 1 ]]; then
        brightnessctl set 1%
      elif [[ $brightness -le 10 ]]; then
        brightnessctl set 1%-
      else
        brightnessctl set 2%-
      fi
      get_brightness
      send_notification
      save_prev_brightness
      ;;
    *)
      print_error
      ;;
    esac
    ;;
  *)
    print_error
    ;;
  esac
done
