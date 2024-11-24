#!/bin/sh

userresources="${HOME}/.Xresources"

if [ -f "${userresources}" ]; then
    xrdb -merge "${userresources}"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        if [ -x "${f}" ]; then
            . "${f}"
        fi
    done

    unset f
fi

xsetroot -cursor_name left_ptr
feh --bg-fill "${HOME}/.wallpaper.jpg" &

picom --config "$HOME/.config/picom.conf" &

MONITOR="DP-0" polybar -r bar&
MONITOR="DP-2" polybar -r bar&

xrandr --output DP-0 --mode 1920x1080 --output DP-2 --mode 1920x1080 --right-of DP-0

dunst &
sxhkd &

exec bspwm
