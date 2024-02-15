#patch for ML4W dotfiles
#patch ment for https://gitlab.com/stephan-raabe/dotfiles by Stephan Raabe

source installer/functions.sh
source installer/packages.sh

#colors
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"

# Set some colors for output messages -- future work
# OK="$(tput setaf 2)[OK]$(tput sgr0)"
# ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
# NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
# WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
# CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
# ORANGE=$(tput setaf 166)
# YELLOW=$(tput setaf 3)
# RESET=$(tput sgr0)

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


#remove .settings files
rm ~/dotfiles/.settings/software.sh
rm ~/dotfiles/.settings/networkmanager.sh

#remove scripts
rm ~/dotfiles/scripts/autolock.sh
rm ~/dotfiles/scripts/bravebookmarks.sh
rm ~/dotfiles/scripts/calculator.sh
rm ~/dotfiles/scripts/checkplatform.sh
rm ~/dotfiles/scripts/fontsearch.sh
rm ~/dotfiles/hypr/scripts/disabledm.sh
rm ~/dotfiles/hypr/scripts/screenshot.sh

# Removes neovim config
rm -rf ~/dotfiles/nvim ~/.config/nvim ~/.local/state/nvim ~/.local/share/nvim mv ~/.cache/nvim

# Removes the app images
rm -rf ~/dotfiles/apps 

# copy dotfiles (cava, neofetch,starship, zsh)
cp -r scipts/backup-dots.sh ~/dotfiles/scripts/
cp -r scipts/laravel-fix.sh ~/dotfiles/scripts/
cp -r scipts/wallpaper.sh ~/dotfiles/hypr/scripts/
cp -r dotfiles/cava ~/dotfiles/
cp -r dotfiles/kitty ~/dotfiles/
cp -r dotfiles/neofetch ~/dotfiles/
cp -r dotfiles/nvim ~/dotfiles/
cp -r dotfiles/.zshrc ~/dotfiles/
cp -r dotfiles/zsh ~/dotfiles/
cp -r dotfiles/yazi ~/dotfiles/
cp -f dotfiles/starship.toml ~/dotfiles/starship/starship.toml

# setup symbolic links
ln -s ~/dotfiles/cava/ ~/.config/
ln -s ~/dotfiles/kitty/ ~/.config/
ln -s ~/dotfiles/neofetch/ ~/.config/
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

# settings
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
sudo sed -i '/^ParallelDownloads = .*/a ILoveCandy' /etc/pacman.conf

#create folders
SCRNSHT=~/Pictures/Screenshots
if [ ! -d "$SCRNSHT" ]; then
	mkdir -p $SCRNSHT
fi

APPFOLD=~/.local/share/applications
if [ ! -d "$APPFOLD" ]; then
	mkdir -p $APPFOLD
fi

THEMEFOLD=~/.local/share/themes
if [ ! -d "$THEMEFOLD" ]; then
	mkdir -p $THEMEFOLD
fi

# copy custom application files
cp applications/*.desktop ~/.local/share/applications/

#themes
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

#grub theme
sudo cp -r darkmatter /boot/grub/themes/
FIND="#GRUB_DISABLE_OS_PROBER=false"
REPLACE="GRUB_DISABLE_OS_PROBER=false"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/default/grub

echo 'GRUB_THEME="/boot/grub/themes/darkmatter/theme.txt"' | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

#switch to zsh shell
chsh -s $(which zsh)

sudo cat <<EOF | crontab -
30 0 * * 7 sh ~/.local/share/bin/autobackup.sh 
EOF

# Enable the Bluetooth servicetem
sleep 2

# Enable the reflector mirror update
echo -e "$CNT - Timer Services...\n"
sudo systemctl enable reflector.timer
sudo systemctl enable fstrim.timer

# Copy power scripts
cp -f dotfiles/power.sh ~/dotfiles/scripts/
cp -f dotfiles/updates.sh ~/dotfiles/scripts/
cp -f dotfiles/installupdates.sh ~/dotfiles/scripts/
cp -f dotfiles/config-power.rasi ~/dotfiles/rofi/

# copy my scripts
cp dotfiles/scripts/setup-ssh.sh ~/dotfiles/scripts/

# Copy Cava weather 
cp dotfiles/cava.sh ~/dotfiles/hypr/scripts/
cp dotfiles/weather-get.sh ~/dotfiles/hypr/scripts/

# New wallpapers
rm -rf ~/wallpaper/
cp -f wallpaper/*.* ~/Pictures/Wallpapers

# Cache file for holding the current wallpaper
echo "* { current-image: url(\"$HOME/Pictures/Wallpapers/default.jpg\", height); }" > $HOME/.cache/current_wallpaper.rasi
echo "$HOME/Pictures/Wallpapers/default.jpg" > $HOME/.cache/current_wallpaper

# override settings from dotfilestem
cp -f dotfiles/keybindings.conf ~/dotfiles/hypr/conf/keybindings/
cp -f dotfiles/3440x1440@144.conf ~/dotfiles/hypr/conf/monitors/
cp -f dotfiles/keyboard.conf ~/dotfiles/hypr/conf/
cp -f dotfiles/monitor.conf ~/dotfiles/hypr/conf/
cp -f dotfiles/browser.sh ~/dotfiles/.settings/

# change keybindings
echo "source = ~/dotfiles/hypr/conf/keybindings/keybindings.conf" > ~/dotfiles/hypr/conf/keybinding.conf

# remove unwanted scripts
rm ~/dotfiles/scripts/cleanup.sh #in alias already
rm ~/dotfiles/scripts/figlet.sh 
rm ~/dotfiles/scripts/filemanager.sh 
rm ~/dotfiles/scripts/growthrate.py
rm ~/dotfiles/scripts/launchvm.sh
rm ~/dotfiles/scripts/looking-glass.sh
rm ~/dotfiles/scripts/onedrive.sh
rm ~/dotfiles/scripts/snapshot.sh
rm ~/dotfiles/scripts/templates.sh

# Write default applications 
echo "kitty" > ~/dotfiles/.settings/terminal.sh
echo "brave" > ~/dotfiles/.settings/browser.sh

# Copy my custom waybar config
cp -r themes/custom ~/dotfiles/waybar/themes
echo "/custom;/custom/light" > ~/.cache/.themestyle.sh

#Display manager
sudo pacman -S --noconfirm greetd
sudo systemctl enable greetd.service

#remove yay
sudo pacman -Rcns yay-git

# Cleaning orphan files
sudo pacman -Rns --noconfirm $(pacman -Qtdq)

#needs testign
zsh
echo '\n[initial_session]\ncommand = "Hyprland"\nuser =' "$USER" | sudo tee -a /etc/greetd/config.toml

#check if everything is ok
bat /etc/greetd/config.toml

echo "     _                   "
echo "  __| | ___  _ __   ___  "
echo " / _' |/ _ \| '_ \ / _ \ "
echo "| (_| | (_) | | | |  __/ "
echo " \__,_|\___/|_| |_|\___| "
echo "                         "
echo  "Remember to check the settings in /etc/xdg/reflector/reflector.conf"
echo ""
echo "Please reboot to start hyprland. Enjoy"
