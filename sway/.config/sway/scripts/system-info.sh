#!/usr/bin/env bash

# System Info Notification Script
# Displays current system stats via notification

# Get date and time
datetime=$(date '+%A, %B %d, %Y • %H:%M:%S')

# Get current workspace
current_workspace=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')
workspace_info="Workspace: ${current_workspace}"

# Get CPU usage (average over 1 second)
cpu_usage=$(top -bn2 -d 0.5 | grep "Cpu(s)" | tail -1 | awk '{print $2}' | cut -d'%' -f1)
cpu_info="CPU: ${cpu_usage}%"

# Get CPU temperature
if command -v sensors &>/dev/null; then
    temp=$(sensors 2>/dev/null | awk '/Package id 0/ {print $4}' | awk -F '[+.]' '{print $2}')
    if [[ -z "$temp" ]]; then
        temp=$(sensors 2>/dev/null | awk '/Tctl/ {print $2}' | tr -d '+°C')
    fi
    if [[ -n "$temp" ]] && [[ "$temp" != "--" ]]; then
        temp=${temp%.*}
        temp_info="Temperature: ${temp}°C"
    else
        temp_info="Temperature: N/A"
    fi
else
    temp_info="Temperature: N/A"
fi

# Get memory usage
mem_info=$(free -h | awk '/^Mem:/ {printf "Memory: %s / %s (%.0f%%)", $3, $2, ($3/$2)*100}')

# Get battery info
battery_info=""
if [ -d "/sys/class/power_supply/BAT0" ]; then
    battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "N/A")
    battery_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "N/A")
    battery_info="Battery: ${battery_capacity}% (${battery_status})"
elif [ -d "/sys/class/power_supply/BAT1" ]; then
    battery_capacity=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null || echo "N/A")
    battery_status=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null || echo "N/A")

    battery_info="Battery: ${battery_capacity}% (${battery_status})"
else
    battery_info="Battery: N/A"
fi

# Get volume info
volume_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
if [ -n "$volume_raw" ]; then
    volume_is_muted=$(echo "$volume_raw" | grep -q MUTED && echo "true" || echo "false")
    volume_level=$(echo "$volume_raw" | awk '{print int($2 * 100)}')

    if [ "$volume_is_muted" = "true" ]; then
        volume_info="Volume: ${volume_level}% (Muted)"
    else
        volume_info="Volume: ${volume_level}%"
    fi
else
    volume_info="Volume: N/A"
fi

# Get brightness info
brightness_raw=$(brightnessctl -m 2>/dev/null | head -n 1)
if [ -n "$brightness_raw" ]; then
    brightness_level=$(echo "$brightness_raw" | grep -o '[0-9]\+%' | head -c-2)
    brightness_info="Brightness: ${brightness_level}%"
else
    brightness_info="Brightness: N/A"
fi

# Get WiFi info
if command -v nmcli &>/dev/null; then
    wifi_status=$(nmcli radio wifi 2>/dev/null)
    if [ "$wifi_status" = "enabled" ]; then
        wifi_info=$(nmcli -t -f active,ssid,signal dev wifi 2>/dev/null | grep "^yes")
        if [ -n "$wifi_info" ]; then
            wifi_ssid=$(echo "$wifi_info" | awk -F: '{print $2}')
            wifi_signal=$(echo "$wifi_info" | awk -F: '{print $3}')
            wifi_info="WiFi: ${wifi_ssid} (${wifi_signal}%)"
        else
            wifi_info="WiFi: No Connection"
        fi
    else
        wifi_info="WiFi: Disabled"
    fi
else
    wifi_info="WiFi: N/A"
fi

# Get VPN info
if command -v nmcli &>/dev/null; then
    vpn_connections=$(nmcli connection show --active 2>/dev/null | grep vpn | awk '{print $1}')
    if [ -n "$vpn_connections" ]; then
        vpn_count=$(echo "$vpn_connections" | wc -l)
        if [ "$vpn_count" -eq 1 ]; then
            vpn_info="VPN: Connected (${vpn_connections})"
        else
            vpn_info="VPN: Connected (${vpn_count} active)"
        fi
    else
        vpn_info="VPN: Disconnected"
    fi
else
    vpn_info="VPN: N/A"
fi

# Build notification message with better ordering
notification_body="${datetime}

${workspace_info}
${wifi_info}
${vpn_info}
${volume_info}
${brightness_info}
${cpu_info}
${temp_info}
${mem_info}
${battery_info}"

# Send notification with app-name
echo "${notification_body}"
notify-send --app-name="System Info" -u normal -t 150000 "System Status" "${notification_body}"
