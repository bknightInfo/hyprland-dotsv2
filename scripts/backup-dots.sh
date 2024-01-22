#!/bin/bash
clear
# ------------------------------------------------------
# Backup existing dotfiles
# ------------------------------------------------------

echo -e "${GREEN}"
figlet "Dot Backup"
echo -e "${NONE}"

# Neovim
cp -rf ~/dotfiles/nvim/ ~/Downloads/hyprland-dotsv2/dotfiles/

echo "backup completed"