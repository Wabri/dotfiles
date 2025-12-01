#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./notify_volume.sh arg-one'
    exit
fi

cd "$(dirname "$0")"

main() {
    level=`awk '{ print $5 }' <(pactl get-sink-volume @DEFAULT_SINK@)`
    dunstify --timeout=600 --urgency=normal "Volume $1 $level"
}

main "$@"
