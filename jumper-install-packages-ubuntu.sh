#!/bin/bash
#~ Write by Jumper Luko
#~ Package faster installer

## ===== ===== =====
## General Functions
#| generate a file log
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
save() {
    tee -a ~/JumperInstalltion_$timestamp.txt
}

#| Show yes or no
yes_or_no() {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) yes_no="yes" && return 0  ;;  
            [Nn]*) printf "Aborted\n\n" ; yes_no="no" && return  1 ;;
        esac
        yes_no="null"
    done
}

#| Testing random things
# functionTest(){
#     echo "Function Test"
#     read -p "$* [y/n]: " yn
# }


## ===== ===== =====
## Apresentação
printf "=== Personal packages by Jumper Luko ===\n"
echo ""
echo "Do you want to start?"
while true; do
    read -p "$* [y/n]: " yn
    case $yn in
        [Yy]*) break ;;
        [Nn]*) printf "\nAborted\n" ; exit ;;
    esac
done

## ===== ===== =====
## Basics programs
function basics() {
    printf "\nInstall basic programs?\n"
    basics="gdebi pwgen figlet geany rawtherapee"
    echo "apt install $basics" | save

    yes_or_no
    if [ "$yes_no" == "no" ];
    then
        return
    fi

    sudo apt install $basics | save
}   
basics

## ===== ===== =====
## PPAs
## CoreCtrl
function PPAs(){
    echo "Install PPAs and packages?" | save
    echo "coreCtrl" | save

    yes_or_no
    if [ "$yes_no" == "no" ];
    then
        return
    fi

    sudo add-apt-repository ppa:ernstp/mesarc | save
    sudo apt update | save
    sudo apt install corectrl -y | save
}
PPAs

# echo "wait 30 seconds, the code is not ready"
# sleep 30

## ===== ===== =====
## dpkg to install DEBs
function debs(){
    echo "Install debs with dpkg?" | save
    dpkgPackages="parsec-linux.deb Minecraft.deb teams_1.3.00.25560_amd64.deb teamviewer_15.10.5_amd64.deb onlyoffice-desktopeditors_amd64.deb steam_latest.deb openrgb_0.5_amd64_88464d1.deb key-mapper-0.8.0.deb google-chrome-stable_current_amd64.deb digimend-dkms_10_all.deb code_1.50.0-1602051089_amd64.deb binance-amd64-linux.deb anydesk_6.0.1-1_amd64.deb"
    echo "$dpkgPackages" | save

    yes_or_no
    if [ "$yes_no" == "no" ];
    then
        return
    fi

    echo "installing???"
    cd /mnt/Jumper-Storage/Programs/deb
    sudo dpkg -i $dpkgPackages | save
    sudo apt install -f && sudo apt update && sudo apt upgrade | save
}
debs

read -p "Enter to exit..."



# add() {
#     result=$(($1 + $2))
#     echo "Result is: $result"
# }

# add 1 2