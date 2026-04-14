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
 
# Check if bluetooth is powered on
POWER_STATUS=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
 
if [[ $POWER_STATUS != "yes" ]]; then
    # Bluetooth is off - offer to turn it on
    CHOICE=$(echo "Turn on Bluetooth" | fuzzel --dmenu ${config_file:+--config "$config_file"})
    if [[ $CHOICE == "Turn on Bluetooth" ]]; then
        bluetoothctl power on
        sleep 2
    else
        exit 0
    fi
fi
 
# Get list of paired devices
PAIRED=$(bluetoothctl devices | awk '{print $2, $3, $4, $5, $6}')
 
# Exit if no devices
[[ -z $PAIRED ]] && exit 0
 
# Get currently connected device MAC addresses
CONNECTED=$(bluetoothctl devices Connected | awk '{print $2}')
 
# Build menu with connected devices marked
LIST=""
while IFS= read -r device; do
    MAC=$(awk '{print $1}' <<< "$device")
    NAME=$(cut -d' ' -f2- <<< "$device")
    
    if echo "$CONNECTED" | grep -q "$MAC"; then
        LIST+="$device ✓"$'\n'
    else
        LIST+="$device"$'\n'
    fi
done <<< "$PAIRED"
 
# Remove trailing newline
LIST=${LIST%$'\n'}
 
# Add separator and disconnect/toggle options
if [[ -n $CONNECTED ]]; then
    LIST+=$'\n'"━━━━━━━━━━━━━━━━"$'\n'"🔌 Disconnect All"
fi
LIST+=$'\n'"━━━━━━━━━━━━━━━━"$'\n'"🔄 Scan for Devices"$'\n'"⏸️  Turn off Bluetooth"
 
# Calculate dimensions
RWIDTH=$(($(echo "$LIST" | head -n 1 | awk '{print length}') + 7))
# LINENUM=$(wc -l <<< "$LIST")
 
# Show menu
CHENTRY=$(fuzzel --dmenu ${config_file:+--config "$config_file"} --width "$RWIDTH" <<< "$LIST")
 
# Exit if user cancelled
[[ -z $CHENTRY ]] && exit 0
 
# Notify function (backgrounded)
notify() {
    (notify-send "$@" --app-name="Bluetooth") &
}
 
# Handle special options
case "$CHENTRY" in
    "🔌 Disconnect All")
        while IFS= read -r mac; do
            bluetoothctl disconnect "$mac" 2>/dev/null
        done <<< "$CONNECTED"
        notify "🔌 Bluetooth Disconnected" "Disconnected all devices" --icon=bluetooth
        exit 0
        ;;
    "🔄 Scan for Devices")
        notify "🔄 Scanning..." "Looking for Bluetooth devices" --icon=bluetooth
        bluetoothctl scan on &
        SCAN_PID=$!
        sleep 5
        kill $SCAN_PID 2>/dev/null
        notify "🔄 Scan Complete" "Check available devices" --icon=bluetooth
        exec "$0"
        ;;
    "⏸️  Turn off Bluetooth")
        bluetoothctl power off
        notify "⏸️  Bluetooth Off" "Bluetooth has been turned off" --icon=bluetooth
        exit 0
        ;;
esac
 
# Remove checkmark if present
CHENTRY_CLEAN=${CHENTRY% ✓}
 
# Extract MAC address (first field)
MAC=$(awk '{print $1}' <<< "$CHENTRY_CLEAN")
 
# Check if already connected
if echo "$CONNECTED" | grep -q "$MAC"; then
    # Disconnect
    if bluetoothctl disconnect "$MAC" 2>/dev/null; then
        DEVICE_NAME=$(cut -d' ' -f2- <<< "$CHENTRY_CLEAN")
        notify "🔌 Disconnected" "Disconnected from $DEVICE_NAME" --icon=bluetooth
    else
        notify "❌ Failed" "Could not disconnect device" --icon=dialog-error --urgency=critical
    fi
else
    # Connect
    if bluetoothctl connect "$MAC" 2>/dev/null; then
        DEVICE_NAME=$(cut -d' ' -f2- <<< "$CHENTRY_CLEAN")
        notify "📶 Connected" "Connected to $DEVICE_NAME" --icon=bluetooth
    else
        notify "❌ Connection Failed" "Could not connect to device" --icon=dialog-error --urgency=critical
    fi
fi
