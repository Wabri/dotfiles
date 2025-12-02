#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./notify_mode.sh arg-one'
    exit
fi

cd "$(dirname "$0")"

main() {
    case $1 in
	    system)
		    mode='System'
                    message=`echo -e "l => [L]ogout\ns => [S]uspend\nh => [H]ibernate\nr => [R]eboot\np => [P]oweroff\nq or escape => go back"`
            ;;
    	    resize)
	            mode='Resize'
		    message=`echo -e "h => resize left \n j => resize down \n k => resize up \n l => resize right\nq or escape => go back"`
            ;;
    	    workspace)
	            mode='Workspace'
		    message=`echo -e "h => move workspace left \n j => move workspace down \n k => move workspace up\n l => move workspace right \n q or escape => go back"`
            ;;
    	    monitor)
	            mode='Monitor'
		    message=`echo -e "h => [H]ome Desk\nd => Home Desk [D]own\nv => Home Desk [V]ertical\ns => [S]olo\nr => Front & [R]ight\nf => [F]ront\n m => Open Arandr\nq or escape => go back"`
            ;;
    	    media)
	            mode='Media'
		    message=`echo -e "h => previous \n j => play \n k => pause \n l => next\ns => toggle play and exit\na => lower audio\nd => upper audio\nm => toggle mute\nq or escape => go back"`
            ;;
    esac
    dunstify --timeout=100000 --urgency=critical "$mode Mode" "$message"
}

main "$@"
