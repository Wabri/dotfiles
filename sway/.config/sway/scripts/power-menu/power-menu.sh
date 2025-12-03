#!/usr/bin/env bash

# Author: Adapted from Jesse Mirabel's rofi script
# Original: https://github.com/sejjy/mechabar
# Adapted for fuzzel by Wabri

set -euo pipefail

# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"

# Fallback if config not found
[[ ! -r "$config_file" ]] && config_file=""

# Notify function (backgrounded)
notify() {
    (notify-send "$@" --app-name="System") &
}

# Show power options
options=(
  "󰍁 Lock"
  " Shutdown"
  " Reboot"
  " Suspend"
  " Hibernate"
  "󰞘 Logout"
)

choice=$(printf "%s\n" "${options[@]}" | fuzzel --dmenu ${config_file:+--config "$config_file"})

case "$choice" in
  *Lock)
    notify "󰍁 Locking..." --urgency=low
    hyprlock
    ;;
  *Shutdown)
    notify " Shutting down..." --urgency=low
    systemctl poweroff
    ;;
  *Reboot)
    notify " Rebooting..." --urgency=low
    systemctl reboot
    ;;
  *Suspend)
    notify " Suspending..." --urgency=low
    systemctl suspend
    ;;
  *Hibernate)
    notify " Hibernating..." --urgency=low
    systemctl hibernate
    ;;
  *Logout)
    notify "󰞘 Logging out..." --urgency=low
    loginctl kill-session "$XDG_SESSION_ID"
    ;;
  *)
    exit 0
    ;;
esac
