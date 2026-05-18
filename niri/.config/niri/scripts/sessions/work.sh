#!/usr/bin/env bash

set -euo pipefail

# Notify function (backgrounded)
notify() {
    (notify-send "$@" --app-name="Sessions") &
}

notify "💼 Work Session" "Starting work apps..." --icon=system-run --expire-time=2000

# Wait function to ensure apps are launched sequentially
wait_a_bit() {
    sleep 0.5
}

flatpak run io.github.focustimerhq.FocusTimer &
wait_a_bit

browsir work gcal &
browsir work gmail &
browsir work suse-tools-backlog-status &
wait_a_bit

flatpak run com.logseq.Logseq &
wait_a_bit

ghostty --title=tmux-ide -e zsh -c 'tmux new -As local' &
wait_a_bit

bitwarden-desktop &
wait_a_bit

flatpak run com.slack.Slack &
wait_a_bit

flatpak run com.blitzfc.qbz &
wait_a_bit

notify "✅ Work Session Ready" "All work applications launched" --icon=emblem-default --expire-time=3000
