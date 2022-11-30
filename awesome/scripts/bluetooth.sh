#!/usr/bin/env bash

# chmod +x ~/dotfiles/awesome/scripts/bluetooth.sh

get_state () {
  state=$(bluetoothctl show | grep 'Powered' | cut -d ' ' -f2-)
  if [[ $state == "yes" ]]; then
    echo on
  else
    echo off
  fi
}

turn_off () {
  bluetoothctl power off 2>&1 > /dev/null
}

turn_on () {
  bluetoothctl power on 2>&1 > /dev/null
}

toggle () {
  state=$(get_state)
  if [[ $state == "on" ]]; then
    turn_off
  else
    turn_on
  fi
}

if [[ $1 == "state" ]]; then
  get_state
fi

if [[ $1 == "toggle" ]]; then
  toggle
fi