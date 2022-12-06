#!/bin/bash

# chmod +x ~/dotfiles/post-install.sh

rmmod pcspkr

# Installing dependencies
echo "Installing dependencies"

sudo pacman -Sy --noconfirm git

cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R nxc:arch ./yay-git
cd yay-git
makepkg -si --noconfirm

PKGS=(
    # NETWORKING
    'wpa_supplicant'
    'network-manager-applet'

    # AUDIO
    'pipewire'
    'pipewire-alsa'
    'pipewire-pulse'
    'alsa-utils'
    'pasystray'
    'playerctl'

    # RICE
    'alacritty'
    'picom-ibhagwan-git'
    'neofetch'
    'rofi'
    'rofi-power-menu'
    'rofimoji'
    'lain-git'
    'catppuccin-gtk-theme'
    'papirus-icon-theme'
    'ttf-roboto'

    # GOODIES
    'librewolf-git'
    'transmission-qt'
    'discord-canary-electron-bin'
    'lxsession'
    'lxappearance'
    'xfce4-power-manager'
    'xss-lock'
    'i3lock-fancy-git'
    'xclip'
    'brightnessctl'
    'nemo'
    'nemo-fileroller'
    'nemo-preview'
    'nemo-terminal'
    'vscodium-bin'
    'remmina'
    'xorg-xset'
    'xorg-xinput'
    'redshift'
)

for PKG in "${PKGS[@]}"; do
    echo "Installing: ${PKG}"
    LANG=C yay -S --noconfirm --answerdiff None --answerclean None "$PKG"
done

# Download dots
echo "Downloading dotfiles"
cd ~
git clone https://github.com/CUFTA22/dotfiles

sh ~/dotfiles/symlink.sh