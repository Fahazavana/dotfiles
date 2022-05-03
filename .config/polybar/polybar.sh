#!/usr/bin/env bash
# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


desktop=$(echo $DESKTOP_SESSION)
if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	if [ $m == 'eDP-1' ] 
	then		
		MONITOR=$m polybar --reload main -c ~/.config/polybar/config.ini &	
	elif [ $m == 'VGA-1' ]
	then
		MONITOR=$m polybar --reload vga -c ~/.config/polybar/config.ini &
	else
		MONITOR=$m polybar --reload hdmi -c ~/.config/polybar/config.ini &
	fi     
      done
    else
    polybar --reload main -c ~/.config/polybar/config.ini &
    fi
# Launch the bar
# polybar -q main -c "$DIR"/config.ini &
