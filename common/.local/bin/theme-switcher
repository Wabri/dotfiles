#!/usr/bin/env bash

set -x

# Define your preferred light and dark color scheme preferences
DARK_PREFERENCE="prefer-dark"
LIGHT_PREFERENCE="prefer-light"

# Define the gsettings schema and key
SCHEMA="org.gnome.desktop.interface"
KEY="color-scheme"

# Get the current color scheme preference
COLOR_SCHEME=$(gsettings get "$SCHEMA" "$KEY" | tr -d "'")

# Check if the current preference is light, then switch to dark, otherwise switch to light
if [ "$COLOR_SCHEME" == "$LIGHT_PREFERENCE" ]; then
    echo "Switching to Dark Theme Preference..."
    gsettings set "$SCHEMA" "$KEY" "$DARK_PREFERENCE"
else
    echo "Switching to Light Theme Preference..."
    gsettings set "$SCHEMA" "$KEY" "$LIGHT_PREFERENCE"
fi

echo "Theme toggle complete. You might need to restart some applications for changes to take full effect."
