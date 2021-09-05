#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Wait until the control has started
polybar -c ~/.config/polybar/config.ini level &
polybar -c ~/.config/polybar/config.ini control &
polybar -c ~/.config/polybar/config.ini workspace &
pgrep spotify && polybar -c ~/.config/polybar/config.ini player &
polybar -c ~/.config/polybar/config.ini open &
polybar -c ~/.config/polybar/config.ini status &
polybar -c ~/.config/polybar/config.ini power &

while [ -z "$(find /tmp -maxdepth 1 -name "polybar*")" ]; do sleep 1; done
polybar-msg cmd hide &
