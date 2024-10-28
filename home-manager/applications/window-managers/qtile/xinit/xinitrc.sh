#!/usr/bin/env bash
feh --no-fehbg --bg-scale '/home/chris/Pictures/background.jpg' &
picom --backend glx &
export XDG_CURRENT_DESKTOP=qtile
export XDG_SESSION_TYPE=x11
export XDG_SESSION_DESKTOP=qtile
export _JAVA_AWT_WM_NONREPARENTING=1
export DISPLAY=:0
xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
xset s off &
xset s 0 0 &
xset -dpms &
lxpolkit &
exec dbus-launch --exit-with-session qtile start
