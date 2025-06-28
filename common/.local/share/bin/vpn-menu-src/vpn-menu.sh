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

LIST=$(nmcli connection show | grep vpn | awk '{print $1}')

# Calculate max width and number of lines
LINENUM=$(echo "$LIST" | wc -l)

CHENTRY=$(echo "$LIST" | fuzzel --dmenu --config "$config_file" --lines "$LINENUM")

ghostty --title=force-floating -e "nmcli connection up $CHENTRY --ask"

