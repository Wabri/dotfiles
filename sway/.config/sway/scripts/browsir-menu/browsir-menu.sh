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

brun() {
  profile=$(browsir --profiles | tail -n +3 | awk '{print $1}' | fuzzel --dmenu --config "$config_file" )
    if [[ -n "$profile" ]]; then
      site=$(browsir -ls | awk '{print $1}' | fuzzel --dmenu --config "$script_dir/fuzzel-sub.conf" )
        if [[ -n "$site" ]]; then
            browsir "$profile" "$site"
        else
            echo "No site selected."
        fi
    else
        echo "No profile selected."
    fi
}

brun
