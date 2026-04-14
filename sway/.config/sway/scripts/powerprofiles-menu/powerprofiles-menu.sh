#!/usr/bin/env bash

set -euo pipefail

# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"

# Fallback if config not found
[[ ! -r "$config_file" ]] && config_file=""

# Get current profile to highlight it
CURRENT=$(powerprofilesctl get 2>/dev/null || echo "balanced")

# Build menu with current selection marked
MENU="[p] Performance"
[[ $CURRENT == "performance" ]] && MENU+=" ✓"
MENU+="
[b] Balanced"
[[ $CURRENT == "balanced" ]] && MENU+=" ✓"
MENU+="
[s] Power Saver"
[[ $CURRENT == "power-saver" ]] && MENU+=" ✓"

# Show menu
choice=$(fuzzel --dmenu ${config_file:+--config "$config_file"} <<< "$MENU")

# Exit if user cancelled
[[ -z $choice ]] && exit 0

# Extract key (first character inside brackets)
key=${choice:1:1}

# Notify function (backgrounded)
notify() {
    (notify-send "$@" --app-name="PowerProfiles") &
}

# Switch profile
case "${key,,}" in  # ${key,,} converts to lowercase
  p)
    if powerprofilesctl set performance 2>/dev/null; then
        notify "󰢾 Performance Mode" "Switched to performance mode"
    else
        notify "❌ Failed" "Could not switch to performance mode" --urgency=critical
    fi
    ;;
  b)
    if powerprofilesctl set balanced 2>/dev/null; then
        notify "󰢽 Balanced Mode" "Switched to balanced mode"
    else
        notify "❌ Failed" "Could not switch to balanced mode" --urgency=critical
    fi
    ;;
  s)
    if powerprofilesctl set power-saver 2>/dev/null; then
        notify "󰢼 Power Saver Mode" "Switched to power saver mode"
    else
        notify "❌ Failed" "Could not switch to power saver mode" --urgency=critical
    fi
    ;;
  *)
    # Invalid or quit - do nothing
    ;;
esac
