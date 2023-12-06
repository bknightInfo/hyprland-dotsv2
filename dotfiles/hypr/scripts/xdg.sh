#!/bin/bash

# start xdg-desktop-portal-hyprland
killall xdg-desktop-portal-hyprland
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2

# start xdg-desktop-portal
killall xdg-desktop-portal
/usr/lib/xdg-desktop-portal &
sleep 1
