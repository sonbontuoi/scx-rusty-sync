#!/bin/bash

POWER_SUPPLY=$(ls /sys/class/power_supply/AC*/online)
STATUS=$(cat "$POWER_SUPPLY")

if [ "$STATUS" -eq 1 ]; then
    echo 1 > /sys/devices/platform/asus-nb-wmi/fan_boost_mode
    systemctl start run_scx_rusty
else
    echo 0 > /sys/devices/platform/asus-nb-wmi/fan_boost_mode
    systemctl stop run_scx_rusty
fi

