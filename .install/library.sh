#!/bin/bash
#  _     _ _                           
# | |   (_) |__  _ __ __ _ _ __ _   _  
# | |   | | '_ \| '__/ _` | '__| | | | 
# | |___| | |_) | | | (_| | |  | |_| | 
# |_____|_|_.__/|_|  \__,_|_|   \__, | 
#                               |___/  
# ----------------------------------------------------- 

# function that will test for a package and if not found it will attempt to install it
_install_software() {
	case $1 in
	pacman)
		APP="sudo pacman"
		;;
	paru)
		APP="paru"
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
			echo -e "$CER - $2 install had failed, please check the install.log"
			exit
		fi
	fi
}

# ------------------------------------------------------
# Create symbolic links
# ------------------------------------------------------
_installSymLink() {
    name="$1"
    symlink="$2";
    linksource="$3";
    linktarget="$4";
    
    if [ -L "${symlink}" ]; then
        rm ${symlink}
        ln -s ${linksource} ${linktarget} 
        echo "Symlink ${linksource} -> ${linktarget} created."
    else
        if [ -d ${symlink} ]; then
            rm -rf ${symlink}/ 
            ln -s ${linksource} ${linktarget}
            echo "Symlink for directory ${linksource} -> ${linktarget} created."
        else
            if [ -f ${symlink} ]; then
                rm ${symlink} 
                ln -s ${linksource} ${linktarget} 
                echo "Symlink to file ${linksource} -> ${linktarget} created."
            else
                ln -s ${linksource} ${linktarget} 
                echo "New symlink ${linksource} -> ${linktarget} created."
            fi
        fi
    fi
}
