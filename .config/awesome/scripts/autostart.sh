#!/bin/bash

# chmod +x ~/dotfiles/.config/awesome/autostart.sh

#!/bin/sh

function run () {
    local cmd=$@
    if ! pgrep -x $cmd; then
        $cmd &
    fi
}

# run picom                 # Compositor
run lxsession             # PolKit
run nm-applet             # NetworkManager
# run flameshot             # Screenshot tool
# run pasystray             # PulseAudio
# run xfce4-power-manager   # Power Management