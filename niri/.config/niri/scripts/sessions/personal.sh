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
browsir personal personal-rmk2 &
wait_a_bit

ghostty --title="distrobox-chachyos-steam" -e zsh -c "distrobox enter cachyos-steam -- steam" &
wait_a_bit

Telegram &
wait_a_bit

flatpak run com.rtosta.zapzap &
wait_a_bit

notify "✅ Personal Session Ready" "All personal applications launched" --icon=emblem-default --expire-time=3000
