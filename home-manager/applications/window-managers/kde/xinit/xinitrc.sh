#!/usr/bin/env bash
export DESKTOP_SESSION=plasma
xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
exec startplasma-x11
