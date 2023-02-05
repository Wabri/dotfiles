#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/"

# Terminate already running bar instances
killall -q polybar

if [[ $? == 1 ]] ; then
  # Wait until the processes have been shut down
  while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

  # Launch the bar
  polybar -q main -c "$DIR"/config.ini &
  polybar -q second -c "$DIR"/config.ini &
fi

