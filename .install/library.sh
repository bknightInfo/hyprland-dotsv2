#!/bin/bash
#  _     _ _                           
# | |   (_) |__  _ __ __ _ _ __ _   _  
# | |   | | '_ \| '__/ _` | '__| | | | 
# | |___| | |_) | | | (_| | |  | |_| | 
# |_____|_|_.__/|_|  \__,_|_|   \__, | 
#                               |___/  
#  
# by Stephan Raabe (2023) 
# ----------------------------------------------------- 

#ToDO: replace with my libraries

# ------------------------------------------------------
# Function: Is package installed
# ------------------------------------------------------
_isInstalledPacman() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

_isInstalledYay() {
    package="$1";
    check="$(yay -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# ------------------------------------------------------
# Function Install all package if not installed
# ------------------------------------------------------
_installPackagesPacman() {
    toInstall=();

    for pkg; do
        if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
            echo "${pkg} is already installed.";
            continue;
        fi;

        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        # echo "All pacman packages are already installed.";
        return;
    fi;

    printf "Package not installed:\n%s\n" "${toInstall[@]}";
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

_installPackagesYay() {
    toInstall=();

    for pkg; do
        if [[ $(_isInstalledYay "${pkg}") == 0 ]]; then
            echo "${pkg} is already installed.";
            continue;
        fi;

        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        # echo "All packages are already installed.";
        return;
    fi;

    printf "AUR packags not installed:\n%s\n" "${toInstall[@]}";
    yay --noconfirm -S "${toInstall[@]}";
}
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

_install_flatpak() {
	echo -e "$CNT - installing flatpak applications"
	for SOFTWR in ${flatpak_stage[@]}; do
		flatpak install --user flathub -y $SOFTWR
	done
}

#remove unwanted applications
remove_software() {
	if $APP -Q $1 &>>/dev/null; then
		sudo pacman -Rcns --noconfirm $1 &>>$INSTLOG
		echo -e "$COK - $1 removed."
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
