#! /usr/bin/env bash

_lock() {
    icon="$HOME/.config/i3/lock.png"
    tmpbg='/tmp/lock.png'
    (( $# )) && { icon=$1; }
    scrot "$tmpbg"
    convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
    convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
	i3lock -i "$tmpbg"
}

lock() {
	case "$2" in
		-f)
			if hash i3lock-fancy 2>/dev/null; then
				i3lock-fancy -p
			else
				echo "i3lock-fancy is not installed. Please install it with: apt install i3lock-fancy"
				_lock
			fi
			;;
		*)
			_lock
	esac
}

case "$1" in
    lock)
        lock $1 $2
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock $1 $2 && systemctl suspend
        ;;
    hibernate)
        lock $1 $2 && systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: i3exit {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
