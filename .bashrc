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
alias please='sudo'

alias dev='yarn dev'

PS1='[\u@\h \W]\$ '
# pnpm
export PNPM_HOME="/home/nxc/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end