#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar(s)
polybar -c ~/.config/polybar/config.ini main &

if (xrandr | grep "DP1-1 connected"); then
    polybar -c ~/.config/polybar/config.ini secondary &
fi
