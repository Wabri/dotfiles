#!/usr/bin/env bash

set -euo pipefail

# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"

# Fallback if config not found
[[ ! -r "$config_file" ]] && config_file=""

# Get VPN connections list
LIST=$(nmcli -t -f NAME,TYPE connection show | awk -F: '$2 == "vpn" {print $1}')

# Exit if no VPNs found
[[ -z $LIST ]] && exit 0

# Calculate number of lines
LINENUM=$(wc -l <<< "$LIST")

# Show menu and get selection
CHENTRY=$(fuzzel --dmenu ${config_file:+--config "$config_file"} --lines "$LINENUM" <<< "$LIST")

# Exit if user cancelled
[[ -z $CHENTRY ]] && exit 0

# Check if password is needed
if nmcli connection up "$CHENTRY" 2>/dev/null; then
  notify-send "🔒 VPN Connected" "Successfully connected to $CHENTRY" --icon=network-vpn
else
  # Password needed - prompt with zenity
  PASSWORD=$(zenity --password --title="VPN Password" --text="Enter password for $CHENTRY")
  [[ -z $PASSWORD ]] && exit 0
  
  if nmcli connection up "$CHENTRY" passwd-file <(echo "vpn.secrets.password:$PASSWORD") 2>/dev/null; then
    notify-send "🔒 VPN Connected" "Successfully connected to $CHENTRY" --icon=network-vpn --app-name="VPN"
  else
    notify-send "❌ VPN Connection Failed" "Wrong password or connection error for $CHENTRY" --icon=dialog-error --urgency=critical --app-name="VPN"
  fi
fi
