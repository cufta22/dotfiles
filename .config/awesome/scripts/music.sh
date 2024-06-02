#!/usr/bin/env bash

title=$(playerctl metadata title || echo '')
artist=$(playerctl metadata artist || echo '')
status=$(playerctl status)

if [[ $status == "Playing" ]]; then
    if [[ $title == *"-"* ]]; then
        echo $title
    else
        echo $artist - $title
    fi
else
    echo ""
fi

# exit