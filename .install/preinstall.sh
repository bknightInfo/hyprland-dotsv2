# ------------------------------------------------------
# Check for required packages to run the installation
# ------------------------------------------------------

# Synchronize packages
sudo pacman -Syy

# ------------------------------------------------------
# Variables
# ------------------------------------------------------
INSTLOG="postinstall-$(date +%d-%H%M%S).log"
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# ------------------------------------------------------
#uncomment pacman settings
# ------------------------------------------------------
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf &>>$INSTLOG
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf &>>$INSTLOG
sudo sed -i '/^ParallelDownloads = .*/a ILoveCandy' /etc/pacman.conf &>>$INSTLOG

# ------------------------------------------------------
# Function: Install AUR
# ------------------------------------------------------
ISAUR=$(command -v paru)
if [ -z "$ISAUR" ]; then
    echo -e "$CWR - Installing paru"
    git clone https://aur.archlinux.org/paru-bin.git paru-git
    cd paru-git
    makepkg -si --noconfirm
    cd ..
    rm -rf paru-git
    echo -e "$COK - paru installed."
fi

# ------------------------------------------------------
# Install rsync
# ------------------------------------------------------
if ! command -v rsync &> /dev/null; then
    sudo pacman -S rsync --noconfirm
fi