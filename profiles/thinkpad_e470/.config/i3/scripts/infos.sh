#! /usr/bin/env bash

date "+  %D%n  %T"
echo "  $(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))"
echo "  $(light -G)"
echo " $(acpi -t | awk '{print $4}')"
echo "  $(cat /sys/class/power_supply/BAT0/capacity)"

