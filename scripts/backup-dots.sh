#!/bin/bash
clear
# ------------------------------------------------------
# Backup existing dotfiles
# ------------------------------------------------------

echo -e "${GREEN}"
figlet "Dot Backup"
echo -e "${NONE}"

# Neovim
rm -rf ~/Downloads/hyprland-dotsv2/dotfiles/nvim
cp -rf ~/dotfiles/nvim/ ~/Downloads/hyprland-dotsv2/dotfiles/

# zsh
cp -rf ~/dotfiles/zsh/ ~/Downloads/hyprland-dotsv2/dotfiles/

echo "backup completed"