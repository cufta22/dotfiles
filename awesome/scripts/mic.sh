#!/usr/bin/env bash

SOURCE=$(pactl get-default-source)

get_state () {
  status=$(pactl get-source-mute $SOURCE | awk '{print $2}')
  echo $status
}

toggle () {
  pactl set-source-mute $SOURCE toggle
}

_ () {
  ${@}
  exit 0
}

if [[ $1 == "state" ]]; then
  get_state
fi

if [[ $1 == "toggle" ]]; then
  toggle
fi