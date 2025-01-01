#!/usr/bin/env bash
# Author: Abraham Cruz <abraham.sustaita@gmail.com>
# License: MIT
#
# This script shows the battery icon depending on the status.

battery_icon() {
  local battery_status
  battery_status=$(pmset -g batt | awk -F '; *' 'NR==2 { print $2 }')

  if [[ $battery_status == "AC attached" || $battery_status == "charged" || $battery_status == "finishing charge" ]]; then
      echo "🔌"
  elif [[ $battery_status == "Battery Warning" ]]; then
      echo "🪫"
  elif [[ $battery_status == "charging" ]]; then
      echo "🔋"
  else
      echo "👇"
  fi
}

battery_icon
