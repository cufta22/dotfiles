#!/bin/bash

bat=/sys/class/power_supply/BAT0/
perc="$(cat "$bat/capacity")"

echo $perc

exit