#!/usr/bin/env fish

# More info : https://github.com/jaagr/polybar/wiki

# Install the following applications for polybar and icons in polybar if you are on ArcoLinuxD
# awesome-terminal-fonts
# Tip : There are other interesting fonts that provide icons like nerd-fonts-complete

if pgrep polybar > /dev/null
    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep polybar > /dev/null
        sleep 1
    end
else
    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep polybar > /dev/null
        sleep 1
    end

    polybar --reload mainbar-i3 -c ~/.config/polybar/config &
    polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
end


