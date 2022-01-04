#!/bin/bash

fpki="sudo flatpak install flathub"

#-S: synchronize your system’s packages with those in the official repo
#-y: download fresh package databases from the server
#-u: upgrade all installed packages
sudo pacman -Syu
sudo pacman -S yay

yay -S pipewire
yay -S pipewire-pulse
yay -R manjaro-pulse
yay -R pulseaudio-jack pulseaudio-lirc pulseaudio-rtp pulseaudio-zeroconf
yay -S pipewire-pulse
#yay -S manjaro-pipewire pipewire-jack-dropin
#echo ‘export PIPEWIRE_LATENCY=“128/48000”’ >> ~/.profile

yay -S --needed pwgen figlet x11vnc qt5ct wine winetricks wine-mono i2c-tools python-pip python-pipx git gitui htop smbclient samba npm sshpass linux515 linux515-headers flatpak flatpak-builder android-tools bash-completion noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-windows ttf-ms-fonts openssh

yay -S --needed --noconfirm geany rawtherapee darktable audacity qbittorrent cheese vlc remmina blender gpick pdfmod pinta minetest menulibre gnome-tweak-tool fontforge kdenlive virt-manager linssid hardinfo remmina-plugin-teamviewer gparted nautilus-share nautilus-compare  nautilus-image-converter nautilus-admin nautilus-hide nautilus-renamer stacer-bin simplescreenrecorder corectrl

yay -S --needed --noconfirm --sudoloop mangohud cpu-x minecraft-launcher teamviewer steam-native steam-manjaro code parsec-bin teams openrgb key-mapper-git google-chrome digimend-kernel-drivers-dkms binance anydesk-bin heroic-games-launcher-bin vivaldi discord betterdiscordctl discover-overlay plex-media-server virtualbox popcorntime motrix-bin spotify brave-browser obs-studio visual-studio-code-bin multisystem tabby-bin forticlient

yay -S amdgpu-pro-libgl opencl-amd

yay -S --needed --noconfirm --sudoloop easyeffects gimp inkscape blender mypaint pavucontrol

yay -S --needed --noconfirm --sudoloop onlyoffice-desktopeditors

$fpki org.gnome.World.PikaBackup

sudo systemctl enable sshd.service
sudo systemctl start sshd.service

echo -r "\n Link Plex folder to /mnt/Jumper-Storage/var/?"
yes_no;if [ $yes_or_no == "yes" ]; then
	sudo systemctl stop plexmediaserver
	sudo rm -r "/var/lib/plex/Plex Media Server"
	sudo ln -s -r "/mnt/Jumper-Storage/var/Plex Media Server/" "/var/lib/plex/"	
	sudo systemctl start plexmediaserver
fi

read -p "Enter to exit..."
