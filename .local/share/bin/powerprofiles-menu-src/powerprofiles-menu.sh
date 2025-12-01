#!/usr/bin/env bash

set -euo pipefail

# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"

# Fallback if config not found
if [ ! -r "$config_file" ]; then
  echo "WARNING: fuzzel config not found at $config_file, continuing without it."
  config_file=""
fi

choice=$(echo "[p] Performance
[b] Balanced
[s] Power Saver
[q] Quit" | fuzzel --dmenu --config "$config_file")

key=$(echo "$choice" | grep -oP '^\[\K.\b')

case "$key" in
  p|P)

  NEW_ID=$()
    powerprofilesctl set performance && notify-send "󰢾 Switched to performance mode" --app-name="PowerProfiles" 
    ;;
  b|B)
    powerprofilesctl set balanced && notify-send "󰢽 Switched to Balanced mode." --app-name="PowerProfiles"
    ;;
  s|S)
    powerprofilesctl set power-saver && notify-send "󰢼 Switched to Power Saver mode." --app-name="PowerProfiles"
    ;;
  q|Q)
    echo "No changes made."
    ;;
  *)
    echo "Invalid option."
    ;;
esac
