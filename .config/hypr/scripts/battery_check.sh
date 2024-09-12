#!/usr/bin/env zsh

while true; do
    val=$(cat /sys/class/power_supply/BAT0/capacity)
    val_num=$((val))

    if [[ $val_num -le 15 ]]; then
        notify-send -u critical "System" "Your battery is $val_num\%" -t 3500
    fi

    sleep 2m
done
