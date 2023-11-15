#!/bin/bash
 
# by Stephan Raabe (2023) 

# ----------------------------------------------------- 
# Define keybindings.conf location
# ----------------------------------------------------- 
config_file=~/dotfiles/hypr/conf/keybindings.conf

# ----------------------------------------------------- 
# Parse keybindings
# ----------------------------------------------------- 
keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
keybinds=$(echo "$keybinds" | sed 's/$mainMod/SUPER/g'|  sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')

# ----------------------------------------------------- 
# Show keybindings in rofi
# ----------------------------------------------------- 
rofi -dmenu -p "Keybinds" -config ~/dotfiles/rofi/config-compact.rasi <<< "$keybinds"