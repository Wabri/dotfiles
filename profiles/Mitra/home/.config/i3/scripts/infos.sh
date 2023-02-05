#! /usr/bin/env bash

date "+Date: %D%nTime: %T"
echo "Volume:  $(awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master))"
echo "Brightness:  $(light -G)"
echo "Temperature: $(acpi -t | awk '{print $4}')"
echo "Battery:  $(cat /sys/class/power_supply/BAT1/capacity)"

