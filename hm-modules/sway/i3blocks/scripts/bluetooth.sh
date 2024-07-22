#!/usr/bin/env sh

devices="$(bluetoothctl devices Connected | cut -d ' ' -f3)"

if [ -n "$devices" ]; then
    echo "$devices"
    echo "$devices"
else
    echo "disconnected"
    echo "disconnected"
fi

open_app() {
    (blueberry &)
}

case $BLOCK_BUTTON in
    1) open_app # left click
esac
