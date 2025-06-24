#!/usr/bin/env bash

# Author: Adapted from Jesse Mirabel's rofi script
# Original: https://github.com/sejjy/mechabar/blob/master/scripts/rofi-bluetooth-menu
# Adapted for fuzzel by Wabri

set -euo pipefail

# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"

# Fallback if config not found
if [ ! -r "$config_file" ]; then
  echo "WARNING: fuzzel config not found at $config_file, continuing without it."
  config_file=""
fi

# Enable Wi-Fi if currently disabled
# Get Wi-Fi list
LIST=$(bluetoothctl devices)

# Calculate max width and number of lines
RWIDTH=$(($(echo "$LIST" | head -n 1 | awk '{print length($0); }')+2))
LINENUM=$(echo "$LIST" | wc -l)

# Current connection info
# CURRIDS=$(bluetoothctl devices | awk '{print $2}')

# Build menu entries
MENU_ENTRIES=$(printf "%s\n" "$LIST" | uniq)

# Show menu
CHENTRY=$(echo "$MENU_ENTRIES" | fuzzel --dmenu --config "$config_file" --lines "$LINENUM" --width "$RWIDTH")

CHSSID=$(echo "$CHENTRY" | awk '{print $2}')

bluetoothctl connect "$CHSSID"
