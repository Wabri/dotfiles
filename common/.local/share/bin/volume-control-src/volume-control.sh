#!/usr/bin/env bash

IDFILE="/tmp/volume_notify_id"
PREVFILE="/tmp/volume_prev_value"

# Print error message for invalid arguments
print_error() {
  cat <<"EOF"
Usage: ./volumecontrol.sh -o <action>
Valid actions are:
    i -- <i>ncrease volume [+5%]
    d -- <d>ecrease volume [-5%]
    m -- <m>ute/unmute toggle
EOF
}

# Get current volume and mute state
get_volume() {
  RAW=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
  MUTE=$(echo "$RAW" | grep -q MUTED && echo "true" || echo "false")
  volume=$(echo "$RAW" | awk '{print int($2 * 100)}')
}

# Determine icon based on volume level
get_icon() {
  if [ "$MUTE" = "true" ]; then
    ICON="󰖁"
  elif ((volume <= 5)); then
    ICON="󰕿"
  elif ((volume <= 50)); then
    ICON="󰖀"
  else
    ICON="󰕾"
  fi
}

# Send notification with volume info
send_notification() {
  get_icon
  if [ -f "$IDFILE" ]; then
    ID=$(cat "$IDFILE")
    [[ -z "$ID" ]] && ID=0
  else
    ID=0
  fi

  if [ "$MUTE" = "true" ]; then
    LABEL="Muted"
  else
    LABEL="${volume}%"
  fi

  NEW_ID=$(notify-send -a "state" "$ICON $LABEL" -h int:value:"$volume" -u low --replace-id=$ID --print-id --app-name="Volume")
  echo "$NEW_ID" > "$IDFILE"
}

# Save current volume to track changes
save_prev_volume() {
  echo "$volume" > "$PREVFILE"
}

get_volume

# Handle options
while getopts o: opt; do
  case "${opt}" in
  o)
    case $OPTARG in
    i) # Increase volume
      wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
      get_volume
      send_notification
      save_prev_volume
      ;;
    d) # Decrease volume
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      get_volume
      send_notification
      save_prev_volume
      ;;
    m) # Mute toggle
      wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      get_volume
      send_notification
      save_prev_volume
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
