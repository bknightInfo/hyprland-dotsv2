echo -e "${CNT}"
cat <<"EOF"
 _                 _        ___  ___                                  
| |               (_)       |  \/  |                                  
| |     ___   __ _ _ _ __   | .  . | __ _ _ __   __ _  __ _  ___ _ __ 
| |    / _ \ / _` | | '_ \  | |\/| |/ _` | '_ \ / _` |/ _` |/ _ \ '__|
| |___| (_) | (_| | | | | | | |  | | (_| | | | | (_| | (_| |  __/ |   
\_____/\___/ \__, |_|_| |_| \_|  |_/\__,_|_| |_|\__,_|\__, |\___|_|   
              __/ |                                    __/ |          
             |___/                                    |___/                                                                                                                                                                                                                       
EOF
echo -e "${NONE}"	

# Enable the greet login manager service
echo -e "$CNT - Activating greet Service..."
if [ -f /etc/systemd/system/display-manager.service ]; then
    sudo rm /etc/systemd/system/display-manager.service
    sudo systemctl enable greetd.service &>>$INSTLOG
fi
read -n1 -rep "${CAT} - Would you like to setup autologin with Greetd? (y,n) " BOOT
if [[ $BOOT == "Y" || $BOOT == "y" ]]; then
    echo '\n[initial_session]\ncommand = "Hyprland"\nuser = "'$USER'"' | sudo tee -a /etc/greetd/config.toml &>>$INSTLOG
fi