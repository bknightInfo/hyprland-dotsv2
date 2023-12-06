
echo -e "${CNT}"
cat <<"EOF"
 _______ _                              
 |__   __| |                             
    | |  | |__   ___ _ __ ___   ___  ___ 
    | |  | '_ \ / _ \ '_ ` _ \ / _ \/ __|
    | |  | | | |  __/ | | | | |  __/\__ \
    |_|  |_| |_|\___|_| |_| |_|\___||___/
                                                                                                    
EOF
echo -e "${NONE}"

git clone https://github.com/yeyushengfan258/Miya-icon-theme.git &>>$INSTLOG
Miya-icon-theme/install.sh -black &>>$INSTLOG
rm -rf Miya-icon-theme &>>$INSTLOG

git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git &>>$INSTLOG
cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Dark-B ~/.local/share/themes/
cp -r Tokyo-Night-GTK-Theme/themes/Tokyonight-Storm-B ~/.local/share/themes/
rm -rf Tokyo-Night-GTK-Theme &>>$INSTLOG

# setup the first look and feel as dark
xfconf-query -c xsettings -p /Net/ThemeName -s "Tokyonight-Dark-B" &>>$INSTLOG
xfconf-query -c xsettings -p /Net/IconThemeName -s "Miya-black-dark" &>>$INSTLOG
gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark-B" &>>$INSTLOG
gsettings set org.gnome.desktop.interface icon-theme "Miya-black-dark" &>>$INSTLOG
gsettings set org.gnome.desktop.interface cursor-theme capitaine-cursors &>>$INSTLOG

#flatpak fix
sudo flatpak override --filesystem=$HOME/.local/share/themes
sudo flatpak override --filesystem=$HOME/.local/share/icons
sudo flatpak override --env=GTK_THEME="Tokyonight-Dark-B"
sudo flatpak override --env=ICON_THEME="Miya-black-dark"
flatpak uninstall --unused && flatpak repair