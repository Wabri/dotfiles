#! /usr/bin/env bash

dunstctl close-all
workspaces=`echo "|"`
for workspace in `i3-msg -t get_workspaces | jq '.[].name' | cut -d '"' -f 2`; do
    workspaces=`echo $workspaces $workspace \|`
done
echo $workspaces
echo " $(awk '{ print $5 }' <(pactl get-sink-volume @DEFAULT_SINK@))  $(br=`light -G`;b=${br%.*};echo $b)%"
echo " cpu ram todo"
echo " network todo"
echo " $(cat /sys/class/power_supply/BAT0/capacity)%  $(acpi -t | awk 'FNR == 1 {print $4}')"
date "+ %d/%m/%y  %T"
