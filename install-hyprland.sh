#!/bin/bash
#  _   _                  _                 _  
# | | | |_   _ _ __  _ __| | __ _ _ __   __| | 
# | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` | 
# |  _  | |_| | |_) | |  | | (_| | | | | (_| | 
# |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_| 
#        |___/|_|                              
#  
# ----------------------------------------------------- 
# Install Script for Hyprland
# ------------------------------------------------------
clear
source .install/library.sh
source .install/hyprland-packages.sh

# ------------------------------------------------------
# Colour variables
# ------------------------------------------------------\
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="$(tput setaf 6)[ATTENTION]$(tput sgr0)"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"

# ------------------------------------------------------
# Variables
# ------------------------------------------------------\v
INSTLOG="postinstall-$(date +%d-%H%M%S).log"
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

read -n1 -rep "${CAT} - Would you like to install Hyprland? (y,n) " INST
if [[ $INST == "Y" || $INST == "y" ]]; then

    # ------------------------------------------------------
    # Function: Install AUR
    # ------------------------------------------------------
    ISAUR=$(command -v yay)
    if [ -z "$ISAUR" ]; then
        echo -e "$CWR - Installing Yay"
        git clone https://aur.archlinux.org/yay-bin.git yay-git
        cd yay-git
        makepkg -si --noconfirm
        cd $SCRIPT_DIR
        rm -rf yay-git
        echo -e "$COK - Yay installed."
    fi

    # ------------------------------------------------------
    # Install required packages
    # ------------------------------------------------------

    echo -e "$CNT - Installing Pacman components, this may take a while..."
    _installPackagesPacman "${packagesPacman[@]}";
    echo ""
    echo -e "$CNT - Installing AUR packages, this may take a while..."
    _installPackagesYay "${packagesYay[@]}";
    echo ""

    # ------------------------------------------------------
    # update directories
    # ------------------------------------------------------
    xdg-user-dirs-update

	# custom desktop files
	APPFOLDER=~/.local/share/applications
	if [ ! -d "$APPFOLDER" ]; then
		mkdir -p $APPFOLDER
	fi

	SCRNSHT=~/Pictures/Screenshots
	if [ ! -d "$SCRNSHT" ]; then
		mkdir -p $SCRNSHT
	fi

	GITHUB="$HOME/Documents/MyGitHub"
	if [ ! -d "$GITHUB" ]; then
		mkdir -p $GITHUB
	fi

    # TODO replace this is with my wallpapers
    # wallpaper folder move
    # ------------------------------------------------------
    # Install wallpapers
    # ------------------------------------------------------

    wget -P ~/Downloads/ https://gitlab.com/stephan-raabe/wallpaper/-/archive/main/wallpaper-main.zip
    unzip -o ~/Downloads/wallpaper-main.zip -d ~/Downloads/
    if [ ! -d ~/wallpaper/ ]; then
        mkdir ~/wallpaper
    fi
    cp ~/Downloads/wallpaper-main/* ~/wallpaper/
    echo -e "$COK - Wallpapers installed successfully."
    cd $SCRIPT_DIR


    # ------------------------------------------------------
    # Copy default wallpaper to .cache
    # ------------------------------------------------------

    echo "-> Copy default wallpaper to .cache"
    cp ~/dotfiles/wallpapers/default.jpg ~/.cache/current_wallpaper.jpg
    echo "Default wallpaper copied."
    echo ""

    # ------------------------------------------------------
    # Add default services
    # ------------------------------------------------------

    # Enable the sddm login manager service
    echo -e "$CNT - Activating sddm Service..."
    sudo systemctl enable sddm -f 
    sleep 2

    # Enable the Bluetooth service
    echo -e "$CNT - Activating Bluetooth Services...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2

    # Enable the reflector mirror update servflatpak uninstall --unused && flatpak repairice
    echo -e "$CNT - Timer Services...\n"
    sudo systemctl enable reflector.timer &>>$INSTLOG
    sudo systemctl enable fstrim.timer 
    sleep 2

    # ------------------------------------------------------
    # Symbolic ZSH link
    # ------------------------------------------------------
    _installSymLink zsh ~/.config/zsh ~/dotfiles/zsh/ ~/.config
    _installSymLink .zshrc ~/.zshrc ~/dotfiles/.zshrc ~/.zshrc

    # ------------------------------------------------------
    # Switch to zsh shell
    # ------------------------------------------------------
    chsh -s $(which zsh)

    # ------------------------------------------------------
    # Install dotfiles
    # ------------------------------------------------------

    _installSymLink cava ~/.config/cava ~/dotfiles/cava/ ~/.config
    _installSymLink dunst ~/.config/dunst ~/dotfiles/dunst/ ~/.config
    _installSymLink .gtkrc-2.0 ~/.gtkrc-2.0 ~/dotfiles/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
    _installSymLink gtk-3.0 ~/.config/gtk-3.0 ~/dotfiles/gtk/gtk-3.0/ ~/.config
    _installSymLink gtk-4.0 ~/.config/gtk-4.0 ~/dotfiles/gtk/gtk-4.0/ ~/.config
    _installSymLink hypr ~/.config/hypr ~/dotfiles/hypr/ ~/.config
    _installSymLink kitty ~/.config/kitty ~/dotfiles/kitty/ ~/.config
    _installSymLink lf ~/.config/lf ~/dotfiles/fl/ ~/.config
    _installSymLink neofetch ~/.config/neofetch ~/dotfiles/neofetch/ ~/.config
    _installSymLink rofi ~/.config/rofi ~/dotfiles/rofi/ ~/.config
    _installSymLink starship ~/.config/starship.toml ~/dotfiles/starship/starship.toml ~/.config/starship.toml
    _installSymLink swappy ~/.config/swappy ~/dotfiles/swappy/ ~/.config
    _installSymLink swaylock ~/.config/swaylock ~/dotfiles/swaylock/ ~/.config
    _installSymLink wal ~/.config/wal ~/dotfiles/wal/ ~/.config
    _installSymLink waybar ~/.config/waybar ~/dotfiles/waybar/ ~/.config
    _installSymLink wlogout ~/.config/wlogout ~/dotfiles/wlogout/ ~/.config      

    wal -i ~/dotfiles/wallpapers/default.jpg

    sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
    sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
    sudo sed -i '/^ParallelDownloads = .*/a ILoveCandy' /etc/pacman.conf

    # ------------------------------------------------------
    # Theme setup
    # ------------------------------------------------------
	THEMES=~/.local/share/themes/
	if [ ! -d "$THEMES" ]; then
		mkdir -p $THEMES
	fi
	git clone https://github.com/yeyushengfan258/Miya-icon-theme.git
	Miya-icon-theme/install.sh -black
	rm -rf Miya-icon-theme

	git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git
	cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Dark-B ~/.local/share/themes/
	cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Storm-B ~/.local/share/themes/
	rm -rf Tokyo-Night-GTK-Theme

	# setup the first look and feel as dark
	xfconf-query -c xsettings -p /Net/ThemeName -s "Tokyonight-Dark-B"
	xfconf-query -c xsettings -p /Net/IconThemeName -s "Miya-black-dark"
	gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark-B"
	gsettings set org.gnome.desktop.interface icon-theme "Miya-black-dark"
	gsettings set org.gnome.desktop.interface cursor-theme capitaine-cursors

    kvantummanager --set Tokyo-Night

    # ------------------------------------------------------
    # grub setup
    # ------------------------------------------------------
	sudo cp -r Extras/darkmatter /boot/grub/themes/
	FIND="#GRUB_DISABLE_OS_PROBER=false"
	REPLACE="GRUB_DISABLE_OS_PROBER=false"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/default/grub &>>$INSTLOG

	echo 'GRUB_THEME="/boot/grub/themes/darkmatter/theme.txt"' | sudo tee -a /etc/default/grub &>>$INSTLOG
	sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

read -n1 -rep "${CAT} - Install backup script? [y/n] " BACKUPCRON
if [[ $BACKUPCRON == "Y" || $BACKUPCRON == "y" ]]; then
	BACKUP=~/.backups/
	if [ ! -d "$BACKUP" ]; then
		mkdir -p $BACKUP &>>$INSTLOG
	fi
	BINDIR=~/.local/share/bin
	if [ ! -d "$BINDIR" ]; then
		mkdir -p $BINDIR &>>$INSTLOG
	fi
    cp Extras/autobackup.sh ~.local/share.bin
	cat <<EOF | crontab -
30 0 * * 7 sh ~/.local/share/bin/autobackup.sh 
EOF
fi

cd $HOME
rm .bash*
# Cleaning orphan files
sudo pacman -Rns --noconfirm $(pacman -Qtdq)

echo "     _                   "
echo "  __| | ___  _ __   ___  "
echo " / _' |/ _ \| '_ \ / _ \ "
echo "| (_| | (_) | | | |  __/ "
echo " \__,_|\___/|_| |_|\___| "
echo "                         "
echo  "Remember to check the settings in /etc/xdg/reflector/reflector.conf"
echo ""
echo "Please reboot to start hyprland. Enjoy"
