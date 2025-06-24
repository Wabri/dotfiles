#!/usr/bin/env bash

# Author: Adapted from Jesse Mirabel's rofi script
# Original: https://github.com/sejjy/mechabar
# Adapted for fuzzel by Wabri

set -euo pipefail

# Configuration variables
script_dir=$(dirname "$(readlink -f "$0")")
config_file="$script_dir/fuzzel.conf"

# Fallback if config not found
if [ ! -r "$config_file" ]; then
  echo "WARNING: fuzzel config not found at $config_file, continuing without it."
  config_file=""
fi

IDFILE="/tmp/power_menu_notify_id"

# Show power options
options=(
  "󰍁 Lock"
  " Shutdown"
  " Reboot"
  " Suspend"
  " Hibernate"
  "󰞘 Logout"
)

choice=$(printf "%s\n" "${options[@]}" | fuzzel --dmenu --config "$config_file")

case "$choice" in
  *Lock)
    notify-send -r 9991 -u low -a "System" "󰍁 Locking..."
    hyprlock
    ;;
  *Shutdown)
    notify-send -r 9992 -u critical -a "System" " Shutting down..."
    systemctl poweroff
    ;;
  *Reboot)
    notify-send -r 9993 -u normal -a "System" " Rebooting..."
    systemctl reboot
    ;;
  *Suspend)
    notify-send -r 9994 -u low -a "System" " Suspending..."
    systemctl suspend
    ;;
  *Hibernate)
    notify-send -r 9995 -u low -a "System" " Hibernating..."
    systemctl hibernate
    ;;
  *Logout)
    notify-send -r 9996 -u low -a "System" "󰞘 Logging out..."
    loginctl kill-session "$XDG_SESSION_ID"
    ;;
  *)
    exit 0
    ;;
esac
