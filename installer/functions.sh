#!/bin/bash

install_software() {
	case $1 in
	pacman)
		APP="sudo pacman"
		;;
	yay)
		APP="yay"
		;;
	esac
	if $APP -Q $2 &>>/dev/null; then
		echo -e "$COK - $2 is already installed."
	else
		# no package found so installing
		echo -e "$CNT - Now installing $2 ..."
		$APP -S --noconfirm $2 &>>$INSTLOG
		# test to make sure package installed
		if $APP -Q $2 &>>/dev/null; then
			echo -e "\e[1A\e[K$COK - $2 was installed."
		else
			# if this is hit then a package is missing, exit to review log
			echo -e "\e[1A\e[K$CER - $2 install had failed, please check the install.log"
			exit
		fi
	fi
}

remove_software() {
	if $APP -Q $2 &>>/dev/null; then
		sudo pacman -Rcns $2 --noconfirm &>>$INSTLOG
		echo -e "$COK - $2 removed."
	fi
}
