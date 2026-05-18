#!/usr/bin/env bash

set -euo pipefail

# Notify function (backgrounded)
notify() {
    (notify-send "$@" --app-name="Sessions") &
}

notify "🏠 Personal Session" "Starting personal apps..." --icon=system-run --expire-time=2000

# Wait function to ensure apps are launched sequentially
wait_a_bit() {
    sleep 0.5
}

browsir personal pmail &
browsir personal pcal &
wait_a_bit

ghostty --title="distrobox-bazzite" -e zsh -c "distrobox enter bazzite-arch" &
wait_a_bit

Telegram &
browsir personal whatsapp &
wait_a_bit

notify "✅ Personal Session Ready" "All personal applications launched" --icon=emblem-default --expire-time=3000
