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
if [[ $(nmcli -fields WIFI g) =~ "disabled" ]]; then
  nmcli radio wifi on
  sleep 5
  nmcli dev wifi rescan &>/dev/null
else
  # Scan for Wi-Fi networks
  nmcli dev wifi rescan &>/dev/null
fi

# Get Wi-Fi list
FIELDS="SSID,SECURITY"
LIST=$(nmcli --fields "$FIELDS" device wifi list | sed '/^--/d')

# Calculate max width and number of lines
RWIDTH=$(($(echo "$LIST" | head -n 1 | awk '{print length($0); }')+2))
LINENUM=$(echo "$LIST" | wc -l)

# Current connection info
CURRSSID=$(LANG=C nmcli -t -f active,ssid dev wifi | awk -F: '$1 ~ /^yes/ {print $2}')

# Determine highlight line (offset by 1 due to "manual" and toggle options)
if [[ -n "$CURRSSID" ]]; then
  HIGHLINE=$(echo  "$(echo "$LIST" | awk -F "[  ]{2,}" '{print $1}' | grep -Fxn -m 1 "$CURRSSID" | awk -F ":" '{print $1}') + 2" | bc )
fi

# Build menu entries
TOGGLE="toggle off"
MENU_ENTRIES=$(printf "%s\n" "$TOGGLE" "manual" "$LIST" | uniq)

# Show menu
CHENTRY=$(echo "$MENU_ENTRIES" | fuzzel --dmenu --config "$config_file" --lines "$LINENUM" --width "$RWIDTH")

CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/|/g' | awk -F "|" '{print $1}')

# Handle choices
case "$CHENTRY" in
  "manual")
    MSSID=$(echo "SSID,password" | fuzzel --dmenu --config "$config_file" --prompt "Manual Entry")
    MPASS=$(echo "$MSSID" | awk -F "," '{print $2}')
    SSID=$(echo "$MSSID" | awk -F "," '{print $1}')
    if [ -z "$MPASS" ]; then
      nmcli dev wifi con "$SSID"
    else
      nmcli dev wifi con "$SSID" password "$MPASS"
    fi
    ;;
  "toggle on")
    nmcli radio wifi on
    sleep 1
    nmcli dev wifi rescan &>/dev/null
    exec "$0"
    ;;
  "toggle off")
    nmcli radio wifi off
    ;;
  *)
    if [ "$CHSSID" = "*" ]; then
      CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/|/g' | awk -F "|" '{print $3}')
    fi
    if nmcli connection show | grep -q "$CHSSID"; then
      nmcli con up "$CHSSID"
    else
      if [[ "$CHENTRY" =~ "WPA2" ]] || [[ "$CHENTRY" =~ "WEP" ]]; then
        WIFIPASS=$(echo "Enter password" | fuzzel --dmenu --config "$config_file" --prompt "Password")
      fi
      nmcli dev wifi con "$CHSSID" password "$WIFIPASS"
    fi
    ;;
esac
