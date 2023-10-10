#!/bin/bash

# chmod +x ~/dotfiles/symlink.sh

mydotfiles=$HOME/dotfiles   # Your dotfiles path
myuser=nxc                  # Your user

ln -s $mydotfiles/.config/alacritty  ~/.config
ln -s $mydotfiles/.config/pipewire   ~/.config
ln -s $mydotfiles/.config/neofetch   ~/.config
ln -s $mydotfiles/.config/picom      ~/.config
ln -s $mydotfiles/.config/rofi       ~/.config
ln -s $mydotfiles/.config/cava       ~/.config

# Random configs
sudo rm -rd /etc/X11/xorg.conf.d
sudo ln -s $mydotfiles/xorg.conf.d  /etc/X11
sudo cp $mydotfiles/modprobe.d/nobeep.conf /etc/modprobe.d/nobeep.conf
sudo cp $mydotfiles/modprobe.d/usbhid.conf /etc/modprobe.d/usbhid.conf
sudo mkdir /etc/pacman.d/hooks
sudo cp $mydotfiles/pacman.d/nvidia.hook /etc/pacman.d/hooks/nvidia.hook
sudo cp $mydotfiles/pacman.d/pacman-cache-cleanup.hook /etc/pacman.d/hooks/pacman-cache-cleanup.hook

# Bash config
rm /home/$myuser/.bash_profile
rm /home/$myuser/.bashrc
ln -s $mydotfiles/.bash_profile  ~/
ln -s $mydotfiles/.bashrc        ~/

# For some reason LightDM doesn't work well with symlinks the files are copied
# to LightDM config directory, this means that when you make some changes in dotfiles
# you'll have to run this script again :(
sudo rm /etc/lightdm/lightdm-gtk-greeter.conf
sudo rm -rd /etc/lightdm/assets

sudo cp $mydotfiles/lightdm/lightdm-gtk-greeter.conf  /etc/lightdm/lightdm-gtk-greeter.conf
sudo cp -r $mydotfiles/lightdm/assets                 /etc/lightdm/assets
