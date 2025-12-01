#!/bin/bash

# Location to store the video
mkdir -p "$HOME/Videos/Screencasts"
FILENAME="recording-$(date +%Y-%m-%d_%H-%M-%S).mp4"
FILEPATH="$HOME/Videos/Screencasts/$FILENAME"

# Temp files to track state
PIDFILE="/tmp/wf-recording.pid"
PATHFILE="/tmp/wf-recording-path"
STARTFILE="/tmp/wf-recording-start"

# If already recording
if pgrep -x wf-recorder > /dev/null; then
    # Stop recording
    pkill wf-recorder

    # Get stored info
    FILEPATH=$(cat "$PATHFILE" 2>/dev/null)
    START_TIME=$(cat "$STARTFILE" 2>/dev/null)
    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))

    # Format time
    MINUTES=$((DURATION / 60))
    SECONDS=$((DURATION % 60))
    LENGTH=$(printf "%02d:%02d" "$MINUTES" "$SECONDS")

    # Notification
    if [[ -f "$FILEPATH" ]]; then
        notify-send "🛑 Stopped" "Saved to:\n$FILEPATH\n⏱ Duration: $LENGTH" --icon=dialog-information --app-name="Recording"
        wl-copy <<< "$FILEPATH"
    else
        notify-send "🛑 Stopped" "But no file was saved." --icon=dialog-information --app-name="Recording"
    fi

    # Clean up
    rm -f "$PIDFILE" "$PATHFILE" "$STARTFILE"
else
    # Start recording
    echo "$FILEPATH" > "$PATHFILE"
    date +%s > "$STARTFILE"
    notify-send "📹 Started" "Saving to:\n$FILEPATH" --icon=dialog-information --app-name="Recording"

    wf-recorder --file "$FILEPATH" --audio --muxer mp4 &
    echo $! > "$PIDFILE"
fi
