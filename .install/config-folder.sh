# ------------------------------------------------------
# Create .config folder
# ------------------------------------------------------

# update directories
xdg-user-dirs-update

if [ ! -d ~/.config ]; then
    mkdir ~/.config
    echo ".config folder created."
fi

SCRNSHT=~/Pictures/Screenshots
if [ ! -d "$SCRNSHT" ]; then
	mkdir -p $SCRNSHT
fi