#!/usr/bin/env bash

script_dir=$(dirname "$(readlink -f "$0")")

brun() {
  profile=$(browsir --profiles | tail -n +3 | awk '{print $1}' | fuzzel --dmenu --config "$script_dir/fuzzel.conf")
    if [[ -n "$profile" ]]; then
      site=$(browsir -ls | awk '{print $1}' | fuzzel --dmenu --config "$script_dir/fuzzel-sub.conf")
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
