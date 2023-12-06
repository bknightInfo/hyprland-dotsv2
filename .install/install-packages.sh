# ------------------------------------------------------
# Install required packages
# ------------------------------------------------------
echo -e "$CNT - Installing main components, this may take a while..."
for SOFTWR in ${packagesPacman[@]}; do
	_install_software "pacman" $SOFTWR
done

echo -e "$CNT - Installing AUR system tools, this may take a while..."
for SOFTWR in ${packagesParu[@]}; do
	install_software "paru" $SOFTWR
done

# Stage flatpak
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo -e "$CNT - installing flatpak applications"
for SOFTWR in ${packagesFlatpak[@]}; do
	flatpak install --user flathub -y $SOFTWR
done