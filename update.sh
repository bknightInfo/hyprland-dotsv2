#!/bin/bash

#packages
source installer/functions.sh
source installer/packages.sh

#colors
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"

INSTLOG="postinstall-$(date +%d-%H%M%S).log"

# clean up files
echo -e "$CNT - removing unwanted applications"
_removePackagesPacman "${removePacman[@]}";

# Stage 1 - main components
echo -e "$CNT - Installing main components, this may take a while..."
_installPackagesPacman "${packagesPacman[@]}";

# Stage AUR - AUR applications
echo -e "$CNT - Installing AUR system tools, this may take a while..."
_installPackagesYay "${packagesYay[@]}";

echo "Adding 'flathub' as repository for 'flatpak'"
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Stage AUR - AUR applications
echo -e "$CNT - Installing flatpaks, this may take a while..."
_installPackagesFlatpak "${packagesFlatpak[@]}";

#remove scripts
rm ~/dotfiles/scripts/autolock.sh
rm ~/dotfiles/scripts/bravebookmarks.sh
rm ~/dotfiles/scripts/checkplatform.sh
rm ~/dotfiles/scripts/fontsearch.sh
rm ~/dotfiles/hypr/scripts/disabledm.sh
rm ~/dotfiles/hypr/scripts/screenshot.sh

# Removes neovim config
rm -rf ~/dotfiles/nvim ~/.config/nvim ~/.local/state/nvim ~/.local/share/nvim mv ~/.cache/nvim

# copy dotfiles (cava, fastfetch,starship, zsh)
cp -r scipts/backup.sh ~/dotfiles/scripts/
cp -r scipts/backup-dots.sh ~/dotfiles/scripts/
cp -r dotfiles/cava ~/dotfiles/
cp -r dotfiles/cmus ~/dotfiles/
cp -r dotfiles/kitty ~/dotfiles/
cp -r dotfiles/fastfetch ~/dotfiles/
cp -r dotfiles/neofetch ~/dotfiles/
cp -r dotfiles/nvim ~/dotfiles/
cp -r dotfiles/.zshrc ~/dotfiles/
cp -r dotfiles/zsh ~/dotfiles/
cp -r dotfiles/yazi ~/dotfiles/
cp -f dotfiles/starship.toml ~/dotfiles/starship/starship.toml

# setup symbolic links
ln -s ~/dotfiles/cava/ ~/.config/
ln -s ~/dotfiles/cmus/ ~/.config/
ln -s ~/dotfiles/kitty/ ~/.config/
ln -s ~/dotfiles/fastfetch/ ~/.config/
ln -s ~/dotfiles/zsh/ ~/.config/
ln -s ~/dotfiles/.zshrc ~
ln -s ~/dotfiles/yazi/ ~/.config/
ln -s ~/dotfiles/nvim/ ~/.config/

# remove unwanted folders
rm -rf ~/dotfiles/alacritty
rm -rf ~/dotfiles/login
rm -rf ~/dotfiles/picom
rm -rf ~/dotfiles/pollybar
rm -rf ~/dotfiles/qtile
rm -rf ~/dotfiles/screenshots
rm -rf ~/dotfiles/sddm
rm -rf ~/dotfiles/vim
rm -rf ~/dotfiles/wlogout

# remove orphan links
rm ~/.config/alacritty
rm ~/.config/vim
rm ~/.config/wlogout
