#!/bin/bash

fpki="sudo flatpak install flathub"

#-S: synchronize your system’s packages with those in the official repo
#-y: download fresh package databases from the server
#-u: upgrade all installed packages
sudo pacman -Syu
sudo pacman -S yay paru

yay -S pipewire
yay -S pipewire-pulse
yay -R manjaro-pulse
yay -R pulseaudio-jack pulseaudio-lirc pulseaudio-rtp pulseaudio-zeroconf
yay -S pipewire-pulse
#yay -S manjaro-pipewire pipewire-jack-dropin
#echo ‘export PIPEWIRE_LATENCY=“128/48000”’ >> ~/.profile

yay -S --needed pwgen figlet x11vnc qt5ct wine winetricks wine-mono i2c-tools python-pip python-pipx git gitui htop smbclient samba npm sshpass linux515 linux515-headers flatpak flatpak-builder android-tools bash-completion noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-windows ttf-ms-fonts openssh openssh-askpass x11-ssh-askpass xpad-dkms-git gnome-session-properties startup-settings-git adduser

yay -S --needed --noconfirm geany rawtherapee darktable audacity qbittorrent cheese vlc remmina blender gpick pdfmod pinta minetest menulibre gnome-tweak-tool fontforge kdenlive virt-manager linssid hardinfo remmina-plugin-teamviewer gparted nautilus-share nautilus-image-converter nautilus-admin nautilus-hide nautilus-renamer nautilus-ext-git-git nautilus-wipe stacer-bin simplescreenrecorder corectrl

yay -S --needed --noconfirm --sudoloop mangohud cpu-x minecraft-launcher teamviewer steam-native steam-manjaro parsec-bin teams openrgb input-remapper-git google-chrome digimend-kernel-drivers-dkms binance anydesk-bin heroic-games-launcher-bin vivaldi discord betterdiscordctl discover-overlay plex-media-server virtualbox popcorntime motrix-bin spotify brave-browser visual-studio-code-bin multisystem tabby-bin forticlient webapp-manager tor

# Create link if chrome stable exists
if [ -e  "/usr/bin/google-chrome-stable" ];  then
	sudo ln -s "/usr/bin/google-chrome-stable" "/usr/bin/google-chrome"
fi

yay -S amdgpu-pro-libgl opencl-amd

yay -S --needed --noconfirm --sudoloop easyeffects gimp inkscape blender mypaint pavucontrol

yay -S --needed --noconfirm --sudoloop onlyoffice-desktopeditors com.obsproject.Studio

$fpki org.gnome.World.PikaBackup org.onionshare.OnionShare com.github.micahflee.torbrowser-launcher org.electrum.electrum org.dash.electrum.electrum_dash com.belmoussaoui.Decoder
$fpki com.adobe.Flash-Player-Projector

sudo systemctl enable sshd.service
sudo systemctl start sshd.service

echo -r "\n Link Plex folder to /mnt/Jumper-Storage/var/?"
yes_no;if [ $yes_or_no == "yes" ]; then
	sudo systemctl stop plexmediaserver
	sudo rm -r "/var/lib/plex/Plex Media Server"
	sudo ln -s -r "/mnt/Jumper-Storage/var/Plex Media Server/" "/var/lib/plex/"	
	sudo systemctl start plexmediaserver
fi

# Brave link
sudo ln -s /usr/bin/brave /usr/bin/brave-browser

sudo systemctl enable smb.service
sudo systemctl start smb.service
sudo smbpasswd -a $USER
sudo gpasswd -a $USER sambashare
sudo usermod -aG sambausers $USER
sudo usermod -aG sambashare $USER
#net usershare add $USER
#sudo nano /etc/samba/smb.conf

yay -S autofs cifs-utils smbclient #udev mount


read -p "Enter to exit..."
