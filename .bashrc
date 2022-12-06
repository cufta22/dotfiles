#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

neofetch

alias ls='ls --color=auto'

alias p-S='sudo pacman -Syyu'
alias p-R='sudo pacman -Rcns'
alias p-Q='pacman -Qs'

alias woman='man'

alias dev='yarn dev'

PS1='[\u@\h \W]\$ '