#!/usr/bin/env bash

# Parse args
MODE="${1:-full}"
USE_CLIPBOARD="$2"

# Output path
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
FILEPATH="$HOME/Pictures/Screenshots/${TIMESTAMP}.png"
mkdir -p "$HOME/Pictures/Screenshots"

# Notify (backgrounded to not block)
notify() {
    local path="$1"
    local clipboard_msg="💾 Saved to disk"
    [[ $USE_CLIPBOARD == "--clipboard" ]] && clipboard_msg="📋 Copied to clipboard"
    (notify-send "📸 Screenshot Taken" "$path\n$clipboard_msg" --icon=dialog-information --app-name="Screenshot") &
}

# Save image and maybe copy to clipboard
handle_output() {
    local path="$1"
    [[ $USE_CLIPBOARD == "--clipboard" ]] && wl-copy < "$path"
    notify "$path"
}

# Screenshot logic
case "$MODE" in
    area)
        grim -g "$(slurp)" "$FILEPATH" && handle_output "$FILEPATH"
        ;;
    selected_window)
        GEOM=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
        [[ -n $GEOM ]] && grim -g "$GEOM" "$FILEPATH" && handle_output "$FILEPATH"
        ;;
    focused_window)
        GEOM=$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')
        [[ -n $GEOM ]] && grim -g "$GEOM" "$FILEPATH" && handle_output "$FILEPATH"
        ;;
    focused_output)
        OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
        [[ -n $OUTPUT ]] && grim -o "$OUTPUT" "$FILEPATH" && handle_output "$FILEPATH"
        ;;
    full)
        grim "$FILEPATH" && handle_output "$FILEPATH"
        ;;
    *)
        echo "Usage: $0 [full|area|selected_window|focused_window|focused_output] [--clipboard]" >&2
        exit 1
        ;;
esac
