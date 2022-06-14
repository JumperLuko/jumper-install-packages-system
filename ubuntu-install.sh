#!/bin/bash
#~ Write by Jumper Luko
#~ Package faster installer for Ubuntu (21.10)
#~ https://github.com/JumperLuko/SicoobLinux-Configs_Apps

source ./functions_variables.sh
stamp "Ubuntu: "

# apt & flatpaks things
apti="sudo apt install"
aptu="sudo apt update"
fpki="sudo flatpak install flathub"


# Apresentação
echo -e "=== Personal packages by Jumper Luko ===\n"

# Gnome Disks
echo -e "\nGnome Disks?"
yes_no;if [ $yes_or_no == "yes" ]; then
    gnome-disks
fi

# Apt update
echo -e "\nApt update?"
yes_no;if [ $yes_or_no == "yes" ]; then
    $aptu
fi

# Apt upgrade
echo -e "\nApt upgrade?"
yes_no;if [ $yes_or_no == "yes" ]; then
    sudo apt upgrade
fi

# Basics packages
echo -e "\nInstall basic packages?"
basics="gdebi pwgen figlet apt-show-versions x11vnc qt5ct lm-sensors python3-pip git git-gui htop adb smbclient samba npm ssh-askpass scrcpy nmapsi4 nmap pipx python3.10-venv rar unrar apt-transport-https curl v4l2loopback-dkms openjdk-16-dbg openjdk-8-dbg screen ninja-build ttf-mscorefonts-installer fonts-noto fonts-noto-cjk fonts-noto-color-emoji libpangox-1.0-0"
echo "apt install $basics"

yes_no;if [ $yes_or_no == "yes" ]; then
    $apti $basics
    echo "updating foto cache"
    sudo fc-cache -f -v
fi

# Zorin Desktop
echo -e "\nZorin OS Desktop?"
yes_no;if [ $yes_or_no == "yes" ]; then
    sudo add-apt-repository ppa:zorinos/stable -y
    sudo add-apt-repository ppa:zorinos/patches -y
    sudo add-apt-repository ppa:zorinos/apps -y
    sudo add-apt-repository ppa:zorinos/drivers -y
    sudo apt update
    $apti zorin-os-desktop --install-recommends
fi

# Zorin Desktop
echo -e "\nPOP OS ppa?"
yes_no;if [ $yes_or_no == "yes" ]; then
    # sudo add-apt-repository ppa:system76/pop
    echo "deb https://apt.pop-os.org/release/ impish main"
    return -p "copie isso acima, clique enter e cole o texto"
    sudo nano /etc/apt/sources.list.d/pop.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 204DD8AEC33A7AFF
fi

# Gnome Desktop
echo -e "\nGnome Desktop?"
yes_no;if [ $yes_or_no == "yes" ]; then
    $apti gnome
fi

# Basics programs
echo -e "\nInstall basic programs?"
programs="geany rawtherapee darktable audacity qbittorrent cheese vlc remmina gpick pdfmod pinta minetest menulibre gnome-tweaks fontforge kdenlive nautilus-extension-gnome-terminal nautilus-image-converter nautilus-admin nautilus-gtkhash nautilus-share nautilus-wipe folder-color grub-customizer virt-manager linssid cpu-x hardinfo gparted synaptic pybik lsp-plugins mangohud lutris stacer simplescreenrecorder galternatives"
echo "apt install $programs"

yes_no;if [ $yes_or_no == "yes" ]; then
    $apti $programs
fi

# PPAs & repos
echo -e "\nInstall PPAs & repos and packages?"
PPApackages="corectrl figma-linux mainline spotify-client multisystem heroic winehq-stable winetricks brave-browser obs-studio"
echo "$PPApackages"

yes_no;if [ $yes_or_no == "yes" ]; then
    sudo add-apt-repository ppa:ernstp/mesarc -y
    sudo add-apt-repository ppa:chrdevs/figma -y
    sudo add-apt-repository ppa:cappelikan/ppa -y
    #sudo add-apt-repository ppa:lutris-team/lutris -y

    # Spotify
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    # Multisystem
    sudo apt-add-repository 'deb http://liveusb.info/multisystem/depot all main' -n
    wget -q -O "-" http://liveusb.info/multisystem/depot/multisystem.asc | sudo apt-key add - 

    # Madlinux for heroic
    echo -e "# MAD Linux > Heroic Games\nPackage: *\nPin: origin sourceforge.net\nPin-Priority: -100\n\nPackage: heroic\nPin: origin sourceforge.net\nPin-Priority: 100" | sudo tee /etc/apt/preferences.d/heroic >/dev/null
    echo 'deb https://sourceforge.net/projects/madlinux/files/repo core main'|sudo tee /etc/apt/sources.list.d/madlinux.list >/dev/null
    wget -qO- Https://sourceforge.net/projects/madlinux/files/repo/madlinux.key|gpg --dearmor|sudo tee /etc/apt/trusted.gpg.d/madlinux.gpg>/dev/null

    # wineHQ Ubuntu 20.04
    sudo dpkg --add-architecture i386 
    wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
    sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ impish main'

    # Brave
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    # OBS
    sudo add-apt-repository ppa:obsproject/obs-studio -n

    $aptu

    $apti $PPApackages
fi

# dpkg to install DEBs
echo -e "\nInstall debs with dpkg?"
dpkgPackages="parsec-linux.deb Minecraft.deb teams_1.3.00.25560_amd64.deb teamviewer_15.10.5_amd64.deb steam_latest.deb openrgb_0.5_amd64_88464d1.deb key-mapper-0.8.0.deb google-chrome-stable_current_amd64.deb digimend-dkms_10_all.deb code_1.50.0-1602051089_amd64.deb binance-amd64-linux.deb anydesk_6.0.1-1_amd64.deb vivaldi-stable_4.0.2312.27-1_amd64.deb discord-0.0.16.deb plexmediaserver_1.23.5.4862-0f739d462_amd64.deb virtualbox-6.1_6.1.24-145767~Ubuntu~eoan_amd64.deb Popcorn-Time-0.4.5-amd64.deb Motrix_1.6.11_amd64.deb webapp-manager_1.1.5_all.deb exodus-linux-x64-21.7.30.deb multimc_1_1-2.deb GDLauncher-linux-setup.deb r2modman_3.1.25_amd64.deb"
echo "$dpkgPackages"

yes_no;if [ $yes_or_no == "yes" ]; then
    cd /mnt/Jumper-Storage/Programs/deb
    sudo dpkg -i $dpkgPackages
    $apti -f
    $aptu
    sudo apt upgrade
fi

# Better Dirscord
echo -e "\n Install Better Discord?"
yes_no;if [ $yes_or_no == "yes" ]; then
    curl -O https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl
    chmod +x betterdiscordctl
    sudo mv betterdiscordctl /usr/local/bin
    betterdiscordctl install
fi

yes_no;if [ $yes_or_no == "yes" ]; then
    sudo snap install $snapPackages
fi

# Disable scroll lock
echo -e "\nComment Scroll lock line of BR keyboard?"
echo "modifier_map Mod3   { Scroll_Lock };"
yes_no;if [ $yes_or_no == "yes" ]; then
    sudo nano /usr/share/X11/xkb/symbols/br
fi

# GDM3 with Xorg
echo -e "\nChange GDM3 config?"
echo "WaylandEnable=false"
yes_no;if [ $yes_or_no == "yes" ]; then
    sudo nano /etc/gdm3/custom.conf
fi

# Default browser
echo -e "\nTrocar browser padrão?"
yes_no;if [ $yes_or_no == "yes" ]; then
    sudo update-alternatives --config x-www-browser
fi

# Samba password
echo -e "\nAdd samba password for this user?"
yes_no;if [ $yes_or_no == "yes" ]; then
    sudo smbpasswd -a $USER
fi

# Remove QT variables
echo -e "\nRemove QT variables on startup?"
echo "You see 'qt-qpa-platformtheme.sh' & 'qt-style-override.sh'?"
ls /etc/profile.d/
yes_no;if [ $yes_or_no == "yes" ]; then
    sudo rm /etc/profile.d/qt-qpa-platformtheme.sh
    sudo rm /etc/profile.d/qt-style-override.sh
fi

#
echo -r "\n Link Plex folder to /mnt/Jumper-Storage/var/?"
yes_no;if [ $yes_or_no == "yes" ]; then
    sudo service plexmediaserver stop
    sudo rm -r "/var/lib/plexmediaserver/Library/Application Support/Plex Media Server"
    sudo ln -s -r "/home/var/Plex Media Server" "/var/lib/plexmediaserver/Library/Application Support/"
    sudo chown plex:plex -R "/home/var/Plex Media Server"
    sudo service plexmediaserver start
fi

read -p "Enter to exit..."

# MangoHud
#git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git
#cd MangoHud
#./build.sh build
#./build.sh package
#./build.sh install

# add() {
#     result=$(($1 + $2))
#     echo "Result is: $result"
# }

# add 1 2

# =========
## NOTES
# https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file#731237
