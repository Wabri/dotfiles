#! /usr/bin/env bash

amixer sset Master 5%-
notify-send --expire-time=600 --urgency=normal "奔 "`awk -F"[][]" '/Left:/ { print $2 }' <(amixer sget Master)`
play ~/.config/i3/tick.mp3
