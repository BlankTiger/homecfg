#!/usr/bin/env bash

LAPTOP_MONITOR="eDP-1"
EXTERNAL_1="DP-3"
EXTERNAL_2="DP-4"

enable_externals() {
    hyprctl keyword monitor "$EXTERNAL_1, 1920x1200@60, 0x0, 1"
    hyprctl keyword monitor "$EXTERNAL_2, 1920x1200@60, 1920x0, 1"
}

disable_externals() {
    hyprctl keyword monitor "$EXTERNAL_1, disable"
    hyprctl keyword monitor "$EXTERNAL_2, disable"
}

restart_externals() {
    disable_externals
    enable_externals
}

handle_monitor_event() {
    case $1 in
        monitoradded>>*)
            hyprctl keyword monitor "$LAPTOP_MONITOR, disable"
            restart_externals
            ;;

        monitorremoved>>*)
            hyprctl keyword monitor "$LAPTOP_MONITOR, preferred, auto, 2"
            disable_externals
            ;;
    esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | \
    while read -r line; do
        handle_monitor_event "$line"
    done
