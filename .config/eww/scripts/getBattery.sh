#!/bin/bash

bat=/sys/class/power_supply/BAT0/
per="$(cat "$bat/capacity")"

percent() {
  echo $per
}

[ "$1" = "percent" ] && percent && exit
exit
