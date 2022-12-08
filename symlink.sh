#!/bin/bash

# chmod +x ~/dotfiles/symlink.sh

mydotfiles=$HOME/dotfiles

# Change for your user
rm -d /home/nxc/.config
ln -s $mydotfiles/alacritty  ~/.config
ln -s $mydotfiles/neofetch   ~/.config
ln -s $mydotfiles/awesome    ~/.config
ln -s $mydotfiles/qtile      ~/.config
ln -s $mydotfiles/picom      ~/.config
ln -s $mydotfiles/conky      ~/.config
ln -s $mydotfiles/rofi       ~/.config
ln -s $mydotfiles/cava       ~/.config

sudo rm -rd /etc/X11/xorg.conf.d
sudo ln -s $mydotfiles/xorg.conf.d  /etc/X11

# Change for your user
rm /home/nxc/.bash_profile
rm /home/nxc/.bashrc
ln -s $mydotfiles/.bash_profile  ~/
ln -s $mydotfiles/.bashrc  ~/

# For some reason LightDM doesn't work well with symlinks the files are copied
# to LightDM config directory, this means that when you make some changes in dotfiles
# you'll have to run this script again :(
sudo rm /etc/lightdm/lightdm-gtk-greeter.conf
sudo rm -rd /etc/lightdm/assets

sudo cp $mydotfiles/lightdm/lightdm-gtk-greeter.conf  /etc/lightdm/lightdm-gtk-greeter.conf
sudo cp -r $mydotfiles/lightdm/assets                 /etc/lightdm/assets
