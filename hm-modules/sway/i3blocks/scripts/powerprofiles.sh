#!/usr/bin/env bash

#
# Script to cycle through power-profiles-daemon profiles.
# When using i3blocks, left click to cycle through profiles.
#

PSET="powerprofilesctl set"
PGET="powerprofilesctl get"

toggle() {
  case $($PGET) in
    performance)
      $PSET power-saver
    ;;
    power-saver)
      $PSET balanced
    ;;
    balanced)
      $PSET performance
    ;;
  esac
}

case $BLOCK_BUTTON in
  1) toggle # left click
esac

case $($PGET) in
  performance)
    echo perf && exit 0
  ;;
  power-saver)
    echo saver && exit 0
  ;;
  balanced)
    echo bal && exit 0 
esac

exit 0
