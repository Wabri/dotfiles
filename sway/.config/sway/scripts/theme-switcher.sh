#!/usr/bin/env bash

# Define your preferred light and dark color scheme preferences
DARK_PREFERENCE="prefer-dark"
LIGHT_PREFERENCE="prefer-light"

# Define the gsettings schema and key
SCHEMA="org.gnome.desktop.interface"
KEY="color-scheme"

# Get the current color scheme preference (remove quotes with parameter expansion)
COLOR_SCHEME=$(gsettings get "$SCHEMA" "$KEY")
COLOR_SCHEME=${COLOR_SCHEME//\'/}  # Remove single quotes

# Toggle theme
if [[ $COLOR_SCHEME == "$LIGHT_PREFERENCE" ]]; then
    gsettings set "$SCHEMA" "$KEY" "$DARK_PREFERENCE"
else
    gsettings set "$SCHEMA" "$KEY" "$LIGHT_PREFERENCE"
fi
