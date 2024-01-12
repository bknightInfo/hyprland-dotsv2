#patch for ML4W dotfiles

# remove packages
sudo pacman -Rcns --noconfirm vim chromium mpv freerdp mousepad vlc python-pip python-psutil python-rich python-click qalculate-gtk man-pages xdg-desktop-portal pfetch trizen pacseek sddm-sugar-candy-git wlr-randr

# install packages
sudo pacman -S --noconfirm bat cronie flatpak neofetch greetd gvfs lf less kitty noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono reflector xfce4-settings zsh zsh-completions zsh-syntax-highlighting

# aur install
yay -S --noconfirm brave-bin cava cmus bibata-cursor-theme fnm-bin grimblast-git solaar zsh-autocomplete-git paru-bin visual-studio-code-bin

# flatpaks
flatpak install -y io.github.celluloid_player.Celluloid org.gnome.Lollypop org.libreoffice.LibreOffice org.filezillaproject.Filezilla com.github.tchx84.Flatseal

# remove orphaned packages
sudo pacman -Rns $(pacman -Qtdq) 

# copy dotfiles (cava, kitty, lf, neofetch,starship, zsh)
cp -r dotfiles/cava ~/dotfiles/
cp -r dotfiles/lf ~/dotfiles/
cp -r dotfiles/kitty ~/dotfiles/
cp -r dotfiles/neofetch ~/dotfiles/
cp dotfiles/.zshrc ~/dotfiles/
cp -r dotfiles/zsh ~/dotfiles/
cp -f dotfiles/starship.toml ~/dotfiles/starship/starship.toml

# setup symbolic links
ln -s ~/dotfiles/cava/ ~/.config/
ln -s ~/dotfiles/lf/ ~/.config/
ln -s ~/dotfiles/kitty/ ~/.config/
ln -s ~/dotfiles/neofetch/ ~/.config/
ln -s ~/dotfiles/zsh/ ~/.config/
ln -s ~/dotfiles/.zshrc ~

# remove symbolic links
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

APPFOLD=~.local/share/applications
if [ ! -d "$APPFOLD" ]; then
	mkdir -p $APPFOLD
fi

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

#flatpak fix
sudo flatpak override --filesystem=$HOME/.local/share/themes
sudo flatpak override --filesystem=$HOME/.local/share/icons
sudo flatpak override --env=GTK_THEME="Tokyonight-Dark-B"
sudo flatpak override --env=ICON_THEME="Miya-black-dark"
flatpak uninstall --unused && flatpak repair

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

#Hyprland keybindings
cp dotfiles/keybindings.conf ~/dotfiles/hypr/conf/keybindings/
cp dotfiles/3440x1440@144.conf ~/dotfiles/hypr/conf/monitors/

# Copy power scripts
cp dotfiles/power.sh ~/dotfiles/scripts/
cp -f dotfiles/updates.sh ~/dotfiles/scripts/
cp -f dotfiles/installupdates.sh ~/dotfiles/scripts/
cp -f dotfiles/config-power.rasi ~/dotfiles/rofi/

# Copy Cava weather 
cp dotfiles/cava.sh ~/dotfiles/hypr/scripts/
cp dotfiles/weather-get.sh ~/dotfiles/hypr/scripts/

# Copy wallpapers
cp -f wallpaper/*.* ~/wallpaper/

#Display manager
sudo pacman -S greetd
sudo systemctl enable greetd.service

echo 'GRUB_THEME="/boot/grub/themes/darkmatter/theme.txt"' | sudo tee -a /etc/greetd/config.toml

#not workiong
echo '\n[initial_session]\ncommand = "Hyprland"\nuser =' "$USER" | sudo tee -a /etc/greetd/config.toml

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
echo  "Remember to check the settings in "
echo ""
echo "Please reboot to start hyprland. Enjoy"