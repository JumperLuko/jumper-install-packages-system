#!/bin/bash

source ./functions_variables.sh
stamp "Flatpak: "

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-add --if-not-exists kdeapps --from https://distribute.kde.org/kdeapps.flatpakrepo

# System tools
fpki com.github.tchx84.Flatseal io.github.arunsivaramanneo.GPUViewer org.gnome.eog
#org.gnome.FileRoller org.gnome.Builder
# Frequently used
fpki org.telegram.desktop com.github.wwmm.easyeffects org.pipewire.Helvum org.pulseaudio.pavucontrol org.gnome.World.PikaBackup io.github.seadve.Kooha org.gnome.Totem com.spotify.Client com.valvesoftware.Steam com.valvesoftware.Steam.CompatibilityTool.Proton com.valvesoftware.Steam.CompatibilityTool.Proton-GE net.davidotek.pupgui2 org.freedesktop.Platform.VulkanLayer.MangoHud com.github.Matoking.protontricks org.gnome.TextEditor
# Artistic
fpki org.gimp.GIMP org.inkscape.Inkscape org.kde.krita org.mypaint.MyPaint org.blender.Blender org.kde.kdenlive io.github.Figma_Linux.figma_linux
# Office
fpki org.onlyoffice.desktopeditors com.github.jeromerobert.pdfarranger us.zoom.Zoom com.slack.Slack
# Security
fpki org.onionshare.OnionShare com.github.micahflee.torbrowser-launcher org.electrum.electrum org.dash.electrum.electrum_dash fr.romainvigier.MetadataCleaner
# Tools common
fpki com.belmoussaoui.Decoder com.github.gi_lom.dialect com.belmoussaoui.Obfuscate org.gnome.Cheese fr.handbrake.ghb org.mozilla.firefox com.usebottles.bottles
# Tools unusual
fpki com.rafaelmardojai.Blanket org.gabmus.whatip com.github.unrud.VideoDownloader org.flozz.yoga-image-optimizer codes.nora.gDiceRoller
# Development
fpki org.gnome.gitlab.somas.Apostrophe org.gnome.design.Contrast io.github.shiftey.Desktop
# Games
fpki io.mrarm.mcpelauncher com.adobe.Flash-Player-Projector net.minetest.Minetest com.atlauncher.ATLauncher org.polymc.PolyMC com.heroicgameslauncher.hgl

echo "Kooha fix?"
yes_no;if [ $yes_or_no == "yes" ]; then
    sudo flatpak update --commit=e52aeb30b4d9f97436de184b6703ae83c48468880d95f0b74916cd6fca3e7c2a io.github.seadve.Kooha
    sudo flatpak mask io.github.seadve.Kooha
fi

# Random things
# com.github.huluti.Curtail org.gnome.BreakTimer com.uploadedlobster.peek com.bitstower.Markets  org.gnome.gitlab.YaLTeR.VideoTrimmer com.github.liferooter.textpieces com.github.johnfactotum.Foliate
# com.github.johnfactotum.QuickLookup org.gnome.gitlab.YaLTeR.Identity com.github.maoschanz.drawing com.leinardi.gst io.github.obiwankennedy.HotShots

# on system is better, or something is better integrate
# org.gnome.Boxes
