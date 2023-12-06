# ------------------------------------------------------
# Install dotfiles
# ------------------------------------------------------
echo -e "${GREEN}"
cat <<"EOF"
 ___           _        _ _       _       _    __ _ _           
|_ _|_ __  ___| |_ __ _| | |   __| | ___ | |_ / _(_) | ___  ___ 
 | || '_ \/ __| __/ _` | | |  / _` |/ _ \| __| |_| | |/ _ \/ __|
 | || | | \__ \ || (_| | | | | (_| | (_) | |_|  _| | |  __/\__ \
|___|_| |_|___/\__\__,_|_|_|  \__,_|\___/ \__|_| |_|_|\___||___/
                                                                
EOF
echo -e "${NONE}"


if [ ! -d ~/dotfiles ]; then
    mkdir ~/dotfiles
    echo "~/dotfiles folder created."
fi   
rsync -a -I $SCRIPT_DIR/dotfiles/ ~/dotfiles/

_installSymLink cava ~/.config/cava ~/dotfiles/cava/ ~/.config
_installSymLink dunst ~/.config/dunst ~/dotfiles/dunst/ ~/.config
_installSymLink gtk-3.0 ~/.config/gtk-3.0 ~/dotfiles/gtk/gtk-3.0/ ~/.config/
_installSymLink gtk-4.0 ~/.config/gtk-4.0 ~/dotfiles/gtk/gtk-4.0/ ~/.config/
_installSymLink hypr ~/.config/hypr ~/dotfiles/hypr/ ~/.config  
_installSymLink kitty ~/.config/kitty ~/dotfiles/kitty/ ~/.config  
_installSymLink lf ~/.config/lf ~/dotfiles/lf/ ~/.config        
_installSymLink neofetch ~/.config/vim ~/dotfiles/neofetch/ ~/.config
_installSymLink nvim ~/.config/nvim ~/dotfiles/nvim/ ~/.config
_installSymLink rofi ~/.config/rofi ~/dotfiles/rofi/ ~/.config
_installSymLink starship ~/.config/starship.toml ~/dotfiles/starship/starship.toml ~/.config/starship.toml
_installSymLink swappy ~/.config/swappy ~/dotfiles/swappy/ ~/.config
_installSymLink swaylock ~/.config/swaylock ~/dotfiles/swaylock/ ~/.config
_installSymLink wallpapers ~/wallpapers ~/dotfiles/wallpapers/ ~/
_installSymLink waybar ~/.config/waybar ~/dotfiles/waybar/ ~/.config
_installSymLink .zsh ~/.config/zsh ~/dotfiles/zsh/ ~/.config
_installSymLink .gtkrc-2.0 ~/.gtkrc-2.0 ~/dotfiles/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
_installSymLink .zshrc ~/.zshrc ~/dotfiles/.zshrc ~/.zshrc
_installSymLink .Xresources ~/.Xresources ~/dotfiles/gtk/.Xresources ~/.Xresources

# ------------------------------------------------------
# Copy default wallpaper to .cache
# ------------------------------------------------------
if [ ! -f ~/.cache/current_wallpaper.jpg ]; then
    cp wallpapers/default.jpg ~/.cache/current_wallpaper.jpg &>>$INSTLOG
    echo "Default wallpaper installed."
    echo ""
fi

# ------------------------------------------------------
# Copy default wallpaper to .cache
# ------------------------------------------------------
if [ ! -f ~/.cache/current_wallpaper.jpg ]; then
    cp ~/wallpapers/default.jpg ~/.cache/current_wallpaper.jpg &>>$INSTLOG
    echo "Default wallpaper installed."
    echo ""
fi         
