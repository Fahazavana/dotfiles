#!/bin/bash
(
  flock 200

  killall -q polybar

  while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done

  outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
  tray_output=eDP1

  for m in $outputs; do
    if [[ $m == "HDMI1" ]]; then
        tray_output=$m
    fi
  done

  for m in $outputs; do
    export MONITOR=$m
    export TRAY_POSITION=none
    if [[ $m == $tray_output ]]; then
      TRAY_POSITION=right
    fi

    polybar --reload main </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- &
    disown
  done
) 200>/var/tmp/polybar-launch.lock














[bar/main]
monitor = ${env:MONITOR:HDMI-1}
tray-position = ${env:TRAY_POSITION:right}

[module/i3]
pin-workspaces = true
















#######################""



killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

desktop=$(echo $DESKTOP_SESSION)

case $desktop in
    i3)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	if [ $m == 'DP-4' ] 
	then		
		MONITOR=$m polybar --reload mainbar-i3 -c ~/.config/polybar/config &	
	elif [ $m == 'HDMI-0' ]
	then
		MONITOR=$m polybar --reload sidebar-1-i3 -c ~/.config/polybar/config &
	else
		MONITOR=$m polybar --reload sidebar-2-i3 -c ~/.config/polybar/config &
	fi     
      done
    else
    polybar --reload mainbar-i3 -c ~/.config/polybar/config &
    fi
    ;;
    openbox)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-openbox -c ~/.config/polybar/config &
      done
    else
    polybar --reload mainbar-openbox -c ~/.config/polybar/config &
    fi
#    if type "xrandr" > /dev/null; then
#      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#        MONITOR=$m polybar --reload mainbar-openbox-extra -c ~/.config/polybar/config &
#      done
#    else
#    polybar --reload mainbar-openbox-extra -c ~/.config/polybar/config &
#    fi

    ;;
    bspwm)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
      done
    else
    polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
    fi
    ;;
esac



[bar/mainbar-i3] ... [bar/sidebar-1-i3] .
