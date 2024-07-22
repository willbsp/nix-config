#!/usr/bin/env sh

devices="$(bluetoothctl devices Connected | cut -d ' ' -f3)"

if [ -n "$devices" ]; then
    echo "$devices"
    echo "$devices"
else
    echo "disconnected"
    echo "disconnected"
fi
