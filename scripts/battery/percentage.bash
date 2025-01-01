#!/usr/bin/env bash
# Author: Abraham Cruz <abraham.sustaita@gmail.com>
# License: MIT
#
# This script calculates the remaining battery percentage.

battery_percentage() {
  local battery_percentage
  battery_percentage=$(pmset -g batt | grep -o '[0-9]\{1,3\}%' | head -n 1)

  echo $battery_percentage
}

battery_percentage
