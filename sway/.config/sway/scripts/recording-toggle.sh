#!/usr/bin/env bash

# Location to store the video
SCREENCAST_DIR="$HOME/Videos/Screencasts"
mkdir -p "$SCREENCAST_DIR"
FILENAME="recording-$(date +%Y-%m-%d_%H-%M-%S).mp4"
FILEPATH="$SCREENCAST_DIR/$FILENAME"

# Temp files to track state
PIDFILE="/tmp/wf-recording.pid"
PATHFILE="/tmp/wf-recording-path"
STARTFILE="/tmp/wf-recording-start"

notify() {
    (notify-send "$@" --icon=dialog-information --app-name="Recording") &
}

# If already recording
if pgrep -x wf-recorder > /dev/null; then
    # Stop recording
    pkill -INT wf-recorder  # Use SIGINT for clean shutdown

    # Get stored info
    FILEPATH=$(cat "$PATHFILE" 2>/dev/null)
    START_TIME=$(cat "$STARTFILE" 2>/dev/null)
    
    # Calculate duration only if we have start time
    if [[ -n $START_TIME ]]; then
        END_TIME=$(date +%s)
        DURATION=$((END_TIME - START_TIME))
        MINUTES=$((DURATION / 60))
        SECONDS=$((DURATION % 60))
        LENGTH=$(printf "%02d:%02d" "$MINUTES" "$SECONDS")
    else
        LENGTH="Unknown"
    fi

    # Wait briefly for file to finalize
    sleep 1

    # Notification
    if [[ -f "$FILEPATH" ]]; then
        notify "🛑 Stopped" "Saved to:\n$FILEPATH\n⏱ Duration: $LENGTH"
        wl-copy <<< "$FILEPATH"
    else
        notify "🛑 Stopped" "But no file was saved."
    fi

    # Clean up
    rm -f "$PIDFILE" "$PATHFILE" "$STARTFILE"
else
    # Start recording
    echo "$FILEPATH" > "$PATHFILE"
    date +%s > "$STARTFILE"
    notify "📹 Started" "Saving to:\n$FILEPATH"

    # Start wf-recorder in background
    wf-recorder --file "$FILEPATH" --audio --muxer mp4 &
    echo $! > "$PIDFILE"
fi
