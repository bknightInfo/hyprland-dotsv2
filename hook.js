#!/bin/bash

//Removes neovim config
rm -rf ~/dotfiles-versions/$version/vim/
rm -rf ~/dotfiles-versions/$version/nvim/

//remove .settings files
rm ~/dotfiles-versions/$version/software.sh
rm ~/dotfiles-versions/$version/networkmanager.sh

//remove scripts
rm ~/dotfiles-versions/$version/scripts/autolock.sh
rm ~/dotfiles-versions/$version/scripts/bravebookmarks.sh
rm ~/dotfiles-versions/$version/scripts/calculator.sh
rm ~/dotfiles-versions/$version/scripts/checkplatform.sh
rm ~/dotfiles-versions/$version/scripts/fontsearch.sh
rm ~/dotfiles-versions/$version/hypr/scripts/disabledm.sh
rm ~/dotfiles-versions/$version/hypr/scripts/screenshot.sh

rm ~/dotfiles-versions/$version/starship/starship.toml

// remove unwanted folders
rm -rf ~/dotfiles-versions/$version/alacritty
rm -rf ~/dotfiles-versions/$version/login
rm -rf ~/dotfiles-versions/$versionpicom
rm -rf ~/dotfiles-versions/$version/pollybar
rm -rf ~/dotfiles-versions/$version/qtile
rm -rf ~/dotfiles-versions/$version/screenshots
rm -rf ~/dotfiles-versions/$version/sddm
rm -rf ~/dotfiles-versions/$version/vim
rm -rf ~/dotfiles-versions/$version/wlogout

# override settings from dotfilestem
rm ~/dotfiles-versions/$version/hypr/conf/keybindings/keybindings.conf
rm ~/dotfiles-versions/$version/hypr/conf/keybinding.conf
rm ~/dotfiles-versions/$version/hypr/conf/monitor.conf
rm -rf ~/dotfiles-versions/$version/.settings/

# remove unwanted scripts
rm ~/dotfiles-versions/$version/scripts/cleanup.sh
rm ~/dotfiles-versions/$version/scripts/figlet.sh 
rm ~/dotfiles-versions/$version/scripts/filemanager.sh 
rm ~/dotfiles-versions/$version/scripts/growthrate.py
rm ~/dotfiles-versions/$version/scripts/launchvm.sh
rm ~/dotfiles-versions/$version/scripts/looking-glass.sh
rm ~/dotfiles-versions/$version/scripts/onedrive.sh
rm ~/dotfiles-versions/$version/scripts/snapshot.sh
rm ~/dotfiles-versions/$version/cripts/templates.sh
