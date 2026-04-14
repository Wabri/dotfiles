#!/usr/bin/env bash

set -euo pipefail

# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"
config_file_sub="$script_dir/fuzzel-sub.conf"

# Fallback if config not found
[[ ! -r "$config_file" ]] && config_file=""
[[ ! -r "$config_file_sub" ]] && config_file_sub=""

# Notify function (backgrounded)
notify() {
    (notify-send "$@" --app-name="Browsir") &
}

# Check if browsir is installed
if ! command -v browsir &> /dev/null; then
    notify "❌ Browsir Not Found" "Please install browsir first" --icon=dialog-error --urgency=critical
    exit 1
fi

# Get profiles list
PROFILES=$(browsir --profiles 2>/dev/null | tail -n +3 | awk '{print $1}')

# Exit if no profiles
if [[ -z $PROFILES ]]; then
    notify "❌ No Profiles Found" "Configure browsir profiles first" --icon=dialog-error --urgency=critical
    exit 1
fi

# Calculate number of lines for profile selection
PROFILE_LINES=$(wc -l <<< "$PROFILES")

# Select profile
PROFILE=$(fuzzel --dmenu ${config_file:+--config "$config_file"} --lines "$PROFILE_LINES" <<< "$PROFILES")

# Exit if user cancelled
[[ -z $PROFILE ]] && exit 0

# Get sites list
SITES=$(browsir -ls 2>/dev/null | awk '{print $1}')

# Exit if no sites
if [[ -z $SITES ]]; then
    notify "❌ No Sites Found" "Add sites to browsir configuration" --icon=dialog-error --urgency=critical
    exit 1
fi

# Calculate number of lines for site selection
SITE_LINES=$(wc -l <<< "$SITES")

# Select site
SITE=$(fuzzel --dmenu ${config_file_sub:+--config "$config_file_sub"} --lines "$SITE_LINES" <<< "$SITES")

# Exit if user cancelled
[[ -z $SITE ]] && exit 0

# Launch browsir
if browsir "$PROFILE" "$SITE" 2>/dev/null; then
    notify "🌐 Opening Browser" "Opening $SITE with $PROFILE profile" --icon=web-browser --expire-time=2000
else
    notify "❌ Launch Failed" "Could not open $SITE with $PROFILE" --icon=dialog-error --urgency=critical
fi
