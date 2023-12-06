echo -e "${CNT}"
cat <<"EOF"
 _____            _     
|  __ \          | |    
| |  \/_ __ _   _| |__  
| | __| '__| | | | '_ \ 
| |_\ \ |  | |_| | |_) |
 \____/_|   \__,_|_.__/ 
                                                                                                                                                               
EOF
echo -e "${NONE}"	
    
#grub theme
sudo cp -r Extras/darkmatter /boot/grub/themes/
FIND="#GRUB_DISABLE_OS_PROBER=false"
REPLACE="GRUB_DISABLE_OS_PROBER=false"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/default/grub &>>$INSTLOG

echo 'GRUB_THEME="/boot/grub/themes/darkmatter/theme.txt"' | sudo tee -a /etc/default/grub &>>$INSTLOG
sudo grub-mkconfig -o /boot/grub/grub.cfg