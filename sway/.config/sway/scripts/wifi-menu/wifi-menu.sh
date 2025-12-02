#!/usr/bin/env bash

# Author: Adapted from Jesse Mirabel's rofi script
# Original: https://github.com/sejjy/mechabar/blob/master/scripts/rofi-bluetooth-menu
# Adapted for fuzzel by Wabri

set -euo pipefail

# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"

# Fallback if config not found
[[ ! -r "$config_file" ]] && config_file=""

# Enable Wi-Fi if currently disabled
if nmcli -g WIFI g | grep -q disabled; then
  nmcli radio wifi on
  sleep 5
fi

# Scan for Wi-Fi networks (backgrounded for speed)
nmcli dev wifi rescan &>/dev/null &

# Get Wi-Fi list
LIST=$(nmcli --fields SSID,SECURITY device wifi list | sed '1d;/^--/d')

# Calculate dimensions
RWIDTH=$(($(echo "$LIST" | head -n 1 | awk '{print length}') + 2))
LINENUM=$(wc -l <<< "$LIST")

# Current connection info
CURRSSID=$(nmcli -t -f active,ssid dev wifi | awk -F: '$1 == "yes" {print $2; exit}')

# Determine highlight line (offset by 2 due to toggle and manual options)
HIGHLINE=0
if [[ -n $CURRSSID ]]; then
  # Find line number of current SSID in the list
  HIGHLINE=$(awk -v ssid="$CURRSSID" '$1 == ssid {print NR+2; exit}' <<< "$LIST")
fi

# Build menu entries
TOGGLE="toggle off"
MENU_ENTRIES=$(printf "%s\n%s\n%s" "$TOGGLE" "manual" "$LIST")

# Show menu
CHENTRY=$(fuzzel --dmenu ${config_file:+--config "$config_file"} --lines "$LINENUM" --width "$RWIDTH" <<< "$MENU_ENTRIES")

# Extract SSID from chosen entry
CHSSID=$(awk '{print $1}' <<< "$CHENTRY")

# Handle choices
case "$CHENTRY" in
  "manual")
    SSID=$(zenity --entry --title="Manual Wi-Fi Connection" --text="Enter SSID:")
    [[ -z $SSID ]] && exit 0
    
    MPASS=$(zenity --password --title="Wi-Fi Password" --text="Enter password for $SSID (or cancel for open network)")
    
    if [[ -z $MPASS ]]; then
      if nmcli dev wifi con "$SSID" 2>/dev/null; then
        notify-send "📶 Wi-Fi Connected" "Successfully connected to $SSID" --icon=network-wireless --app-name="WIFI"
      else
        notify-send "❌ Connection Failed" "Could not connect to $SSID" --icon=dialog-error --urgency=critical --app-name="WIFI"
      fi
    else
      if nmcli dev wifi con "$SSID" password "$MPASS" 2>/dev/null; then
        notify-send "📶 Wi-Fi Connected" "Successfully connected to $SSID" --icon=network-wireless --app-name="WIFI"
      else
        notify-send "❌ Connection Failed" "Wrong password or network unavailable" --icon=dialog-error --urgency=critical --app-name="WIFI"
      fi
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
    # Handle starred (connected) networks
    [[ $CHSSID == "*" ]] && CHSSID=$(awk '{print $3}' <<< "$CHENTRY")
    
    # Try to connect
    if nmcli -t -f NAME connection show | grep -Fxq "$CHSSID"; then
      # Known network - just connect
      if nmcli con up "$CHSSID" 2>/dev/null; then
        notify-send "📶 Wi-Fi Connected" "Successfully connected to $CHSSID" --icon=network-wireless --app-name="WIFI"
      else
        notify-send "❌ Connection Failed" "Could not connect to $CHSSID" --icon=dialog-error --urgency=critical --app-name="WIFI"
      fi
    else
      # New network - check if password needed
      WIFIPASS=""
      if [[ $CHENTRY =~ (WPA|WEP) ]]; then
        WIFIPASS=$(zenity --password --title="Wi-Fi Password" --text="Enter password for $CHSSID")
        [[ -z $WIFIPASS ]] && exit 0
      fi
      
      if nmcli dev wifi con "$CHSSID" ${WIFIPASS:+password "$WIFIPASS"} 2>/dev/null; then
        notify-send "📶 Wi-Fi Connected" "Successfully connected to $CHSSID" --icon=network-wireless --app-name="WIFI"
      else
        notify-send "❌ Connection Failed" "Wrong password or network unavailable" --icon=dialog-error --urgency=critical --app-name="WIFI"
      fi
    fi
    ;;
esac
