#!/bin/bash

source ./functions_variables.sh
stamp "Manjaro: "

. ./dialog-output.sh --backtitle "Jumper Installer" --title "Welcome!" --msgbox "\nWelcome to Jumper Installer for Manjaro!\n\nPlease press enter em type the password" 9 50

#-S: synchronize your system’s packages with those in the official repo
#-y: download fresh package databases from the server
#-u: upgrade all installed packages
sudo pacman -Syu
sudo pacman -S paru-bin

# Snap
##pamac install snapd libpamac-snap-plugin
##ln -s /var/lib/snapd/snap /snap
# pamac install gnome-software-snap

# pipewire audio
echo "=== Pipewire ==="
pami manjaro-pipewire pipewire-jack pipewire-v4l2 pipewire-x11-bell realtime-privileges
# yay -R pulseaudio-jack pulseaudio-lirc pulseaudio-rtp pulseaudio-zeroconf
#yay -S manjaro-pipewire pipewire-jack-dropin
#echo ‘export PIPEWIRE_LATENCY=“128/48000”’ >> ~/.profile

# System basics
echo "=== Basics ==="
pami game-devices-udev bash-completion octopi dialog kdialog pwgen figlet x11vnc qt5ct wine winetricks wine-mono noto-fonts noto-fonts-emoji libgnome-keyring i2c-tools python-pip python-pipx git tk htop smbclient samba npm sshpass flatpak flatpak-builder android-tools openssh openssh-askpass x11-ssh-askpass linux-headers neofetch autofs cifs-utils
pami opencl-amd amdgpu-pro-libgl digimend-kernel-drivers-dkms ttf-windows ttf-ms-fonts gnome-session-properties startup-settings-git adduser
# Too big: noto-fonts-cjk   	

# System extras
echo "=== System Extras ==="
pami xdotool catimg chafa feh menulibre gnome-tweak-tool linssid gparted nautilus-share nautilus-image-converter nautilus-admin v4l2loopback-dkms qgnomeplatform gnome-software malcontent 
pami hardinfo-git nautilus-hide nautilus-renamer nautilus-ext-git-git
# gpu-viewer -> flatpak
# pamac-gnome-integration

# Programs to manage system
echo "=== Apps to system ==="
pami ventoy 
pami corectrl mangohud glfw-wayland glfw-x11 input-remapper-git ventoy cpu-x openrgb-bin
parui thinlinc-server xdg-launch

# Programs
echo "=== Programs ==="
pami vivaldi vivaldi-ffmpeg-codecs discord brave-browser geany rawtherapee audacity qbittorrent remmina freerdp gpick pinta fontforge virt-manager simplescreenrecorder virtualbox webapp-manager tor torsocks
pami waydroid waydroid-image visual-studio-code-bin teamviewer remmina-plugin-teamviewer minecraft-launcher parsec-bin google-chrome binance anydesk-bin betterdiscordctl discover-overlay plex-media-server popcorntime-bin motrix-bin tabby-bin forticlient
parui darling-bin
pamac remove --noconfirm firefox firefox-gnome-theme-maia
# Handbrake -> flatpak
# Not necessary: darktable dcraw perl-image-exiftool gnuplot, teams
# Error: multisystem

# Deepin
echo "=== Deepin apps ==="
pamai deepin-system-monitor deepin-movie

# Printer
echo "=== Printer ==="
# https://wiki.manjaro.org/index.php?title=Printing
# https://wiki.archlinux.org/title/CUPS/Printer-specific_problems#Epson
# Serch in Pamac gui by: priter driver
pamai manjaro-printer system-config-printer ipp-usb hplip epson-inkjet-printer-escpr epson-inkjet-printer-escpr2
sudo gpasswd -a $USER sys
sudo systemctl enable --now cups.service
sudo systemctl enable --now cups.socket
sudo systemctl enable --now cups.path

# Process driver huion
# sudo modprobe -r hid-kye hid-uclogic hid-polostar hid-viewsonic

# yay -R gimp inkscape pavucontrol easyeffects onlyoffice-desktopeditors obs-studio pdfmod cheese
# yay -R steam-native steam-manjaro discord
# paru -R kdenlive minetest totem spotify linux515 linux515-headers

# Plex and Chrome link
# Create link if chrome stable exists
echo "=== Chrome and Chrome fix ==="
if [ -e  "/usr/bin/google-chrome-stable" ] && ! [ -e  "/usr/bin/google-chrome" ];  then
	sudo ln -s "/usr/bin/google-chrome-stable" "/usr/bin/google-chrome"
fi
if [ -e  "/usr/bin/brave" ] && ! [ -e  "/usr/bin/brave-browser" ];  then
	sudo ln -s /usr/bin/brave /usr/bin/brave-browser
fi

# Enable ssh
echo "=== Enable SSH ==="
sudo systemctl enable sshd.service
sudo systemctl start sshd.service

# Plex Jumper
echo "=== Plex config ==="
echo -r "\n Link Plex folder to /mnt/Jumper-Storage/var/?"
yes_no;if [ $yes_or_no == "yes" ]; then
	sudo systemctl stop plexmediaserver
	sudo rm -r "/var/lib/plex/Plex Media Server"
	sudo ln -s -r "/mnt/Jumper-Storage/var/Plex Media Server/" "/var/lib/plex/"	
	sudo systemctl start plexmediaserver
fi

# Samba config
echo "=== Samba config ==="
sudo systemctl enable smb.service
sudo systemctl start smb.service
sudo smbpasswd -a $USER
sudo gpasswd -a $USER sambashare
sudo usermod -aG sambausers $USER
sudo usermod -aG sambashare $USER
#net usershare add $USER
#sudo nano /etc/samba/smb.conf

echo "=== Dialog install ==="
(cd ../dialog-output/ && ./INSTALL.sh)

# Fixes
# QT
echo "Comment QT_QPA_PLATFORMTHEME"
echo "#XDG_SESSION_TYPE=wayland"
echo "QT_QPA_PLATFORM=wayland"
read -p "Enter to continue..."
sudo nano /etc/environment

# # i2c-dev for openrgb
# echo "put i2c-dev"
# read -p "Enter to continue..."
# sudo nano /etc/mkinitcpio.conf
# sudo mkinitcpio -P

read -p "Enter to exit..."
