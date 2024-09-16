#!/usr/bin/env zsh

if [[ -n "$(pgrep waybar)" ]]; then
    killall waybar
else
    waybar
fi
