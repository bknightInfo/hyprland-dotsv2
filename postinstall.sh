#patch for ML4W dotfiles

# remove packages
sudo pacman -Rcns --noconfirm vim chromium mpv freerdp mousepad python-pip python-psutil python-rich python-click qalculate-gtk man-pages xdg-desktop-portal pfetch trizen pacseek wlr-randr xclip xautolock

# install packages
sudo pacman -S --noconfirm bat cronie neofetch greetd lf less kitty noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono reflector xfce4-settings zsh zsh-completions zsh-syntax-highlighting

# aur install
yay -S --noconfirm brave-bin cava cmus deadbeef fnm-bin grimblast-git ngw-look-bin solaar zsh-autocomplete-git paru-bin visual-studio-code-bin

# copy dotfiles (cava, kitty, lf, neofetch,starship, zsh)
cp -r dotfiles/cava ~/dotfiles/
cp -r dotfiles/cmus ~/dotfiles/
cp -r dotfiles/deadbeef ~/dotfiles/
cp -r dotfiles/lf ~/dotfiles/
cp -r dotfiles/kitty ~/dotfiles/
cp -r dotfiles/neofetch ~/dotfiles/
cp dotfiles/.zshrc ~/dotfiles/
cp -r dotfiles/zsh ~/dotfiles/
cp -f dotfiles/starship.toml ~/dotfiles/starship/starship.toml

# setup symbolic links
ln -s ~/dotfiles/cava/ ~/.config/
ln -s ~/dotfiles/cmus/ ~/.config/
ln -s ~/dotfiles/deadbeef/ ~/.config/
ln -s ~/dotfiles/lf/ ~/.config/
ln -s ~/dotfiles/kitty/ ~/.config/
ln -s ~/dotfiles/neofetch/ ~/.config/
ln -s ~/dotfiles/zsh/ ~/.config/
ln -s ~/dotfiles/.zshrc ~

# remove unwanted folders
rm -rf ~/dotfiles/alacritty
rm -rf ~/dotfiles/login
rm -rf ~/dotfiles/picom
rm -rf ~/dotfiles/pollybar
rm -rf ~/dotfiles/qtile
rm -rf ~/dotfiles/screenshots
rm -rf ~/dotfiles/sddm
rm -rf ~/dotfiles/vim

# settings
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
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

LIBFOLD=~/.local/lib/deadbeef
if [ ! -d "$LIBFOLD" ]; then
	mkdir -p $LIBFOLD
fi

#copy deadbeef plugins
cp deadbeef/*.* ~.local/share/applications

# copy custom application files
cp applications/cmus.desktop ~.local/share/applications

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

# Enable the Bluetooth service
echo -e "$CNT - Activating Bluetooth Services...\n"
sudo systemctl enable --now bluetooth.service
sleep 2

# Enable the reflector mirror update
echo -e "$CNT - Timer Services...\n"
sudo systemctl enable reflector.timer
sudo systemctl enable fstrim.timer

# Copy power scripts
cp dotfiles/power.sh ~/dotfiles/scripts/
cp -f dotfiles/updates.sh ~/dotfiles/scripts/
cp -f dotfiles/installupdates.sh ~/dotfiles/scripts/
cp -f dotfiles/config-power.rasi ~/dotfiles/rofi/

# copy my scripts
cp dotfiles/scripts/setup-ssh.sh ~/dotfiles/scripts/

# Copy Cava weather 
cp dotfiles/cava.sh ~/dotfiles/hypr/scripts/
cp dotfiles/weather-get.sh ~/dotfiles/hypr/scripts/

# Copy wallpapers
cp -f wallpaper/*.* ~/wallpaper/

# override settings from dotfiles
cp dotfiles/keybindings.conf ~/dotfiles/hypr/conf/keybindings/
cp dotfiles/3440x1440@144.conf ~/dotfiles/hypr/conf/monitors/
cp -f dotfiles/keyboard.conf ~/dotfiles/hypr/conf/
cp -f dotfiles/keybindings.conf ~/dotfiles/hypr/conf/
cp -f dotfiles/monitor.conf ~/dotfiles/hypr/conf/
cp -f dotfiles/browser.sh ~/dotfiles/.settings/
cp -f dotfiles/kitty.sh ~/dotfiles/.settings/

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

#Display manager
sudo pacman -S greetd
sudo systemctl enable greetd.service

cd $HOME
rm .bash*
# Cleaning orphan files
sudo pacman -Rns --noconfirm $(pacman -Qtdq)

#not workiong
echo '\n[initial_session]\ncommand = "Hyprland"\nuser =' "$USER" | sudo tee -a /etc/greetd/config.toml
bat /etc/greetd/config.toml

echo "     _                   "
echo "  __| | ___  _ __   ___  "
echo " / _' |/ _ \| '_ \ / _ \ "
echo "| (_| | (_) | | | |  __/ "
echo " \__,_|\___/|_| |_|\___| "
echo "                         "
echo  "Remember to check the settings in "
echo ""
echo "Please reboot to start hyprland. Enjoy"