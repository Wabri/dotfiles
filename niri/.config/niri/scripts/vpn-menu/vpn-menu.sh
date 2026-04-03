#!/usr/bin/env bash
 
set -euo pipefail
 
# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"
 
# Fallback if config not found
[[ ! -r "$config_file" ]] && config_file=""
 
# Get VPN connections list
VPN_LIST=$(nmcli -t -f NAME,TYPE connection show | awk -F: '$2 == "vpn" {print $1}')
 
# Exit if no VPNs found
[[ -z $VPN_LIST ]] && exit 0
 
# Get currently active VPN (if any)
ACTIVE_VPN=$(nmcli -t -f NAME,TYPE,STATE connection show --active | awk -F: '$2 == "vpn" && $3 == "activated" {print $1}')
 
# Build menu with active VPN marked
LIST=""
while IFS= read -r vpn; do
    if [[ $vpn == "$ACTIVE_VPN" ]]; then
        LIST+="$vpn ✓"$'\n'
    else
        LIST+="$vpn"$'\n'
    fi
done <<< "$VPN_LIST"
 
# Add disconnect option if a VPN is active
if [[ -n $ACTIVE_VPN ]]; then
    LIST+="━━━━━━━━━━━━━━━━"$'\n'
    LIST+="🔓 Disconnect"$'\n'
fi
 
# Remove trailing newline
LIST=${LIST%$'\n'}
 
# Calculate number of lines
# LINENUM=$(wc -l <<< "$LIST")
 
# Show menu and get selection
CHENTRY=$(fuzzel --dmenu ${config_file:+--config "$config_file"} <<< "$LIST")
 
# Exit if user cancelled
[[ -z $CHENTRY ]] && exit 0
 
# Notify function (backgrounded)
notify() {
    (notify-send "$@" --app-name="VPN") &
}
 
# Handle disconnect option
if [[ $CHENTRY == "🔓 Disconnect" ]]; then
    if [[ -n $ACTIVE_VPN ]]; then
        if nmcli connection down "$ACTIVE_VPN" 2>/dev/null; then
            notify "🔓 VPN Disconnected" "Disconnected from $ACTIVE_VPN" --icon=network-vpn
        else
            notify "❌ Disconnect Failed" "Could not disconnect from $ACTIVE_VPN" --icon=dialog-error --urgency=critical
        fi
    fi
    exit 0
fi
 
# Remove the checkmark if present
CHENTRY=${CHENTRY% ✓}
 
# Check if password is needed
if nmcli connection up "$CHENTRY" 2>/dev/null; then
    notify "🔒 VPN Connected" "Successfully connected to $CHENTRY" --icon=network-vpn
else
    # Password needed - prompt with zenity
    PASSWORD=$(zenity --password --title="VPN Password" --text="Enter password for $CHENTRY")
    [[ -z $PASSWORD ]] && exit 0
    
    if nmcli connection up "$CHENTRY" passwd-file <(echo "vpn.secrets.password:$PASSWORD") 2>/dev/null; then
        notify "🔒 VPN Connected" "Successfully connected to $CHENTRY" --icon=network-vpn
    else
        notify "❌ VPN Connection Failed" "Wrong password or connection error for $CHENTRY" --icon=dialog-error --urgency=critical
    fi
fi
