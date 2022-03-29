#!/bin/bash

# General Functions
# Generate a file log
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
save() {
    tee -a ~/.cache/JumperInstallation.txt
}

stamp () {
    echo "$1 $timestamp" >> $HOME/.cache/JumperInstallation.txt
}

yes_no() {
    unset $yes_or_no
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) yes_or_no="yes" && return 0  ;;  
            [Nn]*) printf "Aborted\n\n" ; yes_or_no="no" && return  1 ;;
        esac
        yes_or_no="null"
    done
}

fpki (){
    sudo flatpak install flathub $1 --system -y
}

dialog=./dialog