#!/bin/bash
#~ Write by Jumper Luko
#~ Package faster installer

# General Functions
# Generate a file log
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
save() {
    tee -a ~/JumperInstalltion_$timestamp.txt
}

# Show yes or no
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
basics="gdebi pwgen figlet apt-show-versions x11vnc qt5ct wine winetricks lm-sensors pip git git-gui htop adb smbclient samba npm ssh-askpass scrcpy nmapsi4 nmap"
echo "apt install $basics"

yes_no;if [ $yes_or_no == "yes" ]; then
    $apti $basics
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

# Gnome Desktop
echo -e "\nGnome Desktop?"
yes_no;if [ $yes_or_no == "yes" ]; then
    $apti gnome
fi

# Basics programs
echo -e "\nInstall basic programs?"
programs="geany rawtherapee darktable audacity qbittorrent cheese vlc remmina blender gpick pdfmod pinta minetest menulibre gnome-tweak-tool fontforge kdenlive nautilus-extension-gnome-terminal nautilus-admin nautilus-gtkhash nautilus-actions nautilus-share nautilus-wipe folder-color grub-customizer virt-manager linssid cpu-x hardinfo gparted synaptic pybik"
echo "apt install $programs"

yes_no;if [ $yes_or_no == "yes" ]; then
    $apti $programs
fi

# PPAs
echo -e "\nInstall PPAs and packages?"
PPApackages="corectrl figma-linux mainline spotify-client multisystem heroic"
echo "$PPApackages"

yes_no;if [ $yes_or_no == "yes" ]; then
    sudo add-apt-repository ppa:ernstp/mesarc -y
    sudo add-apt-repository ppa:chrdevs/figma -y
    sudo add-apt-repository ppa:cappelikan/ppa -y
    #sudo add-apt-repository ppa:lutris-team/lutris -y

    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    sudo apt-add-repository 'deb http://liveusb.info/multisystem/depot all main'
    wget -q -O "-" http://liveusb.info/multisystem/depot/multisystem.asc | sudo apt-key add - 

    sudo echo -e "# MAD Linux > Heroic Games\nPackage: *\nPin: origin sourceforge.net\nPin-Priority: -100\n\nPackage: heroic\nPin: origin sourceforge.net\nPin-Priority: 100" > /etc/apt/preferences.d/heroic
    echo 'deb https://sourceforge.net/projects/madlinux/files/repo core main'|sudo tee /etc/apt/sources.list.d/madlinux.list
    wget -qO- Https://sourceforge.net/projects/madlinux/files/repo/madlinux.key|gpg --dearmor|sudo tee /etc/apt/trusted.gpg.d/madlinux.gpg>/dev/null

    $aptu

    $apti $PPApackages
fi

# dpkg to install DEBs
echo -e "\nInstall debs with dpkg?"
dpkgPackages="parsec-linux.deb Minecraft.deb teams_1.3.00.25560_amd64.deb teamviewer_15.10.5_amd64.deb steam_latest.deb openrgb_0.5_amd64_88464d1.deb key-mapper-0.8.0.deb google-chrome-stable_current_amd64.deb digimend-dkms_10_all.deb code_1.50.0-1602051089_amd64.deb binance-amd64-linux.deb anydesk_6.0.1-1_amd64.deb vivaldi-stable_4.0.2312.27-1_amd64.deb discord-0.0.15.deb plexmediaserver_1.23.5.4862-0f739d462_amd64.deb virtualbox-6.1_6.1.24-145767~Ubuntu~eoan_amd64.deb Popcorn-Time-0.4.5-amd64.deb Motrix_1.6.11_amd64.deb heroic_1.8.2_amd64.deb webapp-manager_1.1.5_all.deb"
echo "$dpkgPackages"

yes_no;if [ $yes_or_no == "yes" ]; then
    cd /mnt/Jumper-Storage/Programs/deb
    sudo dpkg -i $dpkgPackages
    $apti -f
    $aptu
    sudo apt upgrade
fi

# Flatpaks
echo -e "\nInstall Flatpaks?"
fpkPackages="org.gimp.GIMP org.inkscape.Inkscape org.kde.krita io.mrarm.mcpelauncher"
echo $fpkPackages

yes_no;if [ $yes_or_no == "yes" ]; then
    sudo apt install flatpak gnome-software-plugin-flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    $fpki $fpkPackages

    echo -e "\nAll Flatpaks?"
    fpkPackages2="com.rafaelmardojai.Blanket fr.romainvigier.MetadataCleaner org.gabmus.whatip io.github.seadve.Kooha org.gnome.gitlab.somas.Apostrophe org.gnome.World.PikaBackup org.gnome.design.Contrast com.github.gi_lom.dialect com.github.huluti.Curtail com.github.tchx84.Flatseal org.gabmus.hydrapaper org.gnome.BreakTimer com.uploadedlobster.peek com.bitstower.Markets com.github.unrud.VideoDownloader org.gnome.gitlab.YaLTeR.VideoTrimmer com.github.liferooter.textpieces com.github.johnfactotum.Foliate org.gnome.Boxes org.flozz.yoga-image-optimizer com.github.micahflee.torbrowser-launcher org.onlyoffice.desktopeditors"
    fpkPackages3="com.github.johnfactotum.QuickLookup com.belmoussaoui.Obfuscate org.gnome.gitlab.YaLTeR.Identity com.github.maoschanz.drawing com.leinardi.gst io.github.obiwankennedy.HotShots org.onionshare.OnionShare codes.nora.gDiceRoller"
    yes_no;if [ $yes_or_no == "yes" ]; then
        $fpki $fpkPackages2
        $fpki $fpkPackages3
    fi
fi

# Snaps
echo -e "\nInstall Snaps?"
snapPackages="notion-snap"
echo $snapPackages

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
    sudo ln -s -r "/mnt/Jumper-Storage/var/Plex Media Server/" "/var/lib/plexmediaserver/Library/Application Support/"
    sudo chown plex:plex -R "/mnt/Jumper-Storage/var/Plex Media Server/"
    sudo service plexmediaserver start
fi

read -p "Enter to exit..."


# add() {
#     result=$(($1 + $2))
#     echo "Result is: $result"
# }

# add 1 2

# =========
## NOTES
# https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file#731237
