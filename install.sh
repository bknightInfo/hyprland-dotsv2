#!/bin/bash
clear

# ------------------------------------------------------
# colours
# ------------------------------------------------------
  source .install/colours.sh

echo -e "${CNT}"
cat <<"EOF"
  _   _                  _                 _  
 | | | |_   _ _ __  _ __| | __ _ _ __   __| | 
 | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` | 
 |  _  | |_| | |_) | |  | | (_| | | | | (_| | 
 |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_| 
        |___/|_|                              
                                   
EOF
echo -e "${NONE}"

read -n1 -rep "${CAT} - Would you like to install Hyprland? (y,n) " INST
if [[ $INST == "Y" || $INST == "y" ]]; then

# ------------------------------------------------------
# preinstall
# ------------------------------------------------------
  source .install/preinstall.sh

# ------------------------------------------------------
# package install
# ------------------------------------------------------
  source .install/library.sh
  source .install/hyprland-packages.sh
  source .install/install-packages.sh
  
# ------------------------------------------------------
# hyprland configuration
# ----------------------------------------------------
  source .install/config-folder.sh
  source .install/init-pywal.sh
  source .install/dotfiles.sh
  source .install/themes.sh
  source .install/grub.sh
  source .install/services.sh
  source .install/postinstall.sh
fi
