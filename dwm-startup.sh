#!/bin/bash

# Display Configurations
# Due to .75x.75 scaling, the position of display 2 is moved over 1920 instead of 2560
xrandr --output DisplayPort-1 --mode 2560x1440 --scale 0.75x0.75 --pos 0x0 --rotate normal --rate 143.86
xrandr --output DisplayPort-2 --mode 2560x1440 --scale 0.75x0.75 --pos 1920x0 --rotate normal --rate 143.86

# Kensington Slimblade Wireless Config
xinput --set-prop 16 'libinput Accel Speed' 0.2
xinput --set-prop 16 "libinput Middle Emulation Enabled" 1
# Kensington Slimblade Wired Config
xinput --set-prop 18 'libinput Accel Speed' 0.2
xinput --set-prop 18 "libinput Middle Emulation Enabled" 1

# Background image
feh --bg-fill /home/zach/Pictures/wallpaper-xianxia-dragon.jpg

# Compositor
picom --experimental-backends &

# Status Bar
slstatus &

export XDG_CURRENT_DESKTOP=KDE
export XDG_SESSION_DESKTOP=KDE
export KDE_SESSION_VERSION=5
export SAL_USE_VCLPLUGIN=kde5

plover &
keepassxc &
dunst &
xautolock -time 10 -locker slock &

exec dwm
