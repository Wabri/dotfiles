#!/usr/bin/env bash

# Parse args
MODE="$1"
CLIPBOARD="$2"  # pass "--clipboard" if clipboard copy is wanted

# Output path
TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"
FILENAME="$TIMESTAMP.png"
FILEPATH="$HOME/Pictures/Screenshots/$FILENAME"
mkdir -p "$HOME/Pictures/Screenshots"

# Notify
function notify() {
    local path="$1"
    local clip="$2"
    local clipboard_msg=$([ "$clip" = true ] && echo "📋 Copied to clipboard" || echo "💾 Saved to disk")
    notify-send "📸 Screenshot Taken" "$path\n$clipboard_msg" --icon=dialog-information --app-name="Screenshot"
}

# Save image and maybe copy to clipboard
function handle_output() {
    local path="$1"
    if [ "$CLIPBOARD" == "--clipboard" ]; then
        wl-copy < "$path"
        notify "$path" true
    else
        notify "$path" false
    fi
}

# Screenshot logic
case "$MODE" in
    area)
        grim -g "$(slurp)" "$FILEPATH"
        handle_output "$FILEPATH"
        ;;
    selected_window)
        GEOM=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
        grim -g "$GEOM" "$FILEPATH"
        handle_output "$FILEPATH"
        ;;
    focused_window)
        GEOM=$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')
        grim -g "$GEOM" "$FILEPATH"
        handle_output "$FILEPATH"
        ;;
    focused_output)
        OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
        grim -o "$OUTPUT" "$FILEPATH"
        handle_output "$FILEPATH"
        ;;
    full|"")
        grim "$FILEPATH"
        handle_output "$FILEPATH"
        ;;
    *)
        echo "Usage: $0 [full|area|selected_window|focused_window|focused_output] [--clipboard]" >&2
        exit 1
        ;;
esac
