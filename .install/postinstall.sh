echo -e "${CNT}"
cat <<"EOF"
______         _     _____          _        _ _ 
| ___ \       | |   |_   _|        | |      | | |
| |_/ /__  ___| |_    | | _ __  ___| |_ __ _| | |
|  __/ _ \/ __| __|   | || '_ \/ __| __/ _` | | |
| | | (_) \__ \ |_   _| || | | \__ \ || (_| | | |
\_|  \___/|___/\__|  \___/_| |_|___/\__\__,_|_|_|
                                                                                                                                                               
EOF
echo -e "${NONE}"

#switch to zsh shell
chsh -s $(which zsh)

sudo cat <<EOF | crontab -
30 0 * * 7 sh ~/.local/share/bin/autobackup.sh 
EOF

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