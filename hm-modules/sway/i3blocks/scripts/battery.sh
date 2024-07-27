#!/usr/bin/env bash

PSET="powerprofilesctl set"
PGET="powerprofilesctl get"

BATTERY_STATE=$(echo "${BATTERY_INFO}" | upower -i $(upower -e | grep 'battery_BAT') | grep -E "state" | awk '{print $2}')
BATTERY_POWER=$(echo "${BATTERY_INFO}" | upower -i $(upower -e | grep 'battery_BAT') | grep -E "percentage" | awk '{print $2}' | tr -d '%')
URGENT_VALUE=10

if [[ "${BATTERY_POWER}" -gt 85 ]]; then
    TEXT_COLOUR="#A8FF00"
elif [[ "${BATTERY_POWER}" -gt 60 ]]; then
    TEXT_COLOUR="#FFF600"
elif [[ "${BATTERY_POWER}" -gt 40 ]]; then
    TEXT_COLOUR="#FFAE00"
elif [[ "${BATTERY_POWER}" -gt 20 ]]; then
    TEXT_COLOUR="#FF0000"
else
    TEXT_COLOUR=""
fi

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
    BATTERY_PROFILE_TEXT="perf"
  ;;
  power-saver)
    BATTERY_PROFILE_TEXT="save"
  ;;
  balanced)
    BATTERY_PROFILE_TEXT="bal"
esac

if [[ "${BATTERY_STATE}" = "discharging" ]]; then
    BATTERY_STATE_TEXT="dis"
elif [[ "${BATTERY_STATE}" = "fully-charged" ]]; then
    BATTERY_STATE_TEXT="full"
elif [[ "${BATTERY_STATE}" = "charging" ]]; then
    BATTERY_STATE_TEXT="chr"
fi

echo "${BATTERY_POWER}% [${BATTERY_STATE_TEXT}] [${BATTERY_PROFILE_TEXT}]"
echo "${BATTERY_POWER}% [${BATTERY_STATE_TEXT}] [${BATTERY_PROFILE_TEXT}]"
#echo "${TEXT_COLOUR}"

if [[ "${BATTERY_POWER}" -le "${URGENT_VALUE}" ]]; then
  exit 33
fi

exit 0
