#!/usr/bin/env bash

set -euo pipefail

# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"

# Fallback if config not found
[[ ! -r "$config_file" ]] && config_file=""

# Notify function (backgrounded)
notify() {
    (notify-send "$@" --app-name="Sessions") &
}

# Define session options
sessions=(
    "💼 Work"
    "🏠 Personal"
    "🔄 Work + Personal"
)

# Calculate number of lines
SESSION_LINES=$(wc -l <<< "$(printf '%s\n' "${sessions[@]}")")

# Show menu
selected=$(fuzzel --dmenu ${config_file:+--config "$config_file"} --lines "$SESSION_LINES" <<< "$(printf '%s\n' "${sessions[@]}")")

# Exit if user cancelled
[[ -z $selected ]] && exit 0

# Handle selection
case "$selected" in
    "💼 Work")
        notify "🚀 Launching Session" "Loading Work session..." --icon=system-run --expire-time=2000
        "$script_dir/work.sh"
        ;;
    "🏠 Personal")
        notify "🚀 Launching Session" "Loading Personal session..." --icon=system-run --expire-time=2000
        "$script_dir/personal.sh"
        ;;
    "🔄 Work + Personal")
        notify "🚀 Launching Session" "Loading Work + Personal sessions..." --icon=system-run --expire-time=2000
        "$script_dir/work.sh"
        sleep 1
        "$script_dir/personal.sh"
        ;;
    *)
        notify "❌ Cancelled" "No session selected" --icon=dialog-error
        exit 0
        ;;
esac
