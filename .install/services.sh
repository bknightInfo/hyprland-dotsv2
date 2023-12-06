
# Enable the Bluetooth service
echo -e "$CNT - Activating Bluetooth Services...\n"
sudo systemctl enable --now bluetooth.service &>>$INSTLOG
sleep 2

# Enable the reflector mirror update servflatpak uninstall --unused && flatpak repairice
echo -e "$CNT - Timer Services...\n"
sudo systemctl enable reflector.timer &>>$INSTLOG
sudo systemctl enable fstrim.timer &>>$INSTLOG
sleep 2