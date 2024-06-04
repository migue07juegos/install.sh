#!/bin/bash
xbps-install -Syu
xbps-install -y git wget xtools dbus elogind NetworkManager chrony cups nftables polkit 
ln -s /etc/sv/cups /var/service/
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/elogind /var/service/
ln -s /etc/sv/NetworkManager /var/service/
ln -s /etc/sv/chronyd /var/service/
ln -s /etc/sv/nftables /var/service/
ln -s /etc/sv/polkitd /var/service/
xbps-install -y pipewire pavucontrol flatpak

# gpu drivers
xbps-install -y mesa-dri vulkan-loader Vulkan-ValidationLayers mesa-vulkan-intel intel-video-accel
xbps-install -y void-repo-nonfree
xbps-install -Sy nvidia

# flatpak stuff
su mig
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
exit
# reboot

# fonts
xbps-install -y font-firacode nerd-fonts google-fonts-ttf cantarell-fonts

# visual session
cd /home/mig
git clone --depth=1 https://github.com/migue07juegos/void-packages.git -b no-merge
cd void-packages
./xbps-src binary-bootstrap
xgensum -fi niri
./xbps-src pkg niri
./xbps-src pkg swayosd
./xbps-src pkg an-anime-game-launcher
./xbps-src pkg yazi
xi -y niri
xi -y swayosd
xi -y an-anime-game-launcher
xi -y yazi
cd /home/mig
rm -rfd void-packages/
git clone --depth=1 https://github.com/migue07juegos/void-packages.git -b kickoff
cd void-packages
./xbps-src binary-bootstrap
./xbps-src pkg kickoff
xi -y kickoff
cd /home/mig
rm -rfd void-packages/

# apps
xbps-install -y foot neovim mpv thunar firefox keepassxc obs qalculate-gtk PrismLauncher transmission-gtk
xbps-install -y ffmpeg waybar nomacs kimageformats libreoffice xdg-utils dragon npm lua54

# flatpak apps
su mig
flatpak install com.github.tchx84.Flatseal
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.heroicgameslauncher.hgl
flatpak install com.github.iwalton3.jellyfin-media-player
flatpak install net.epson.epsonscan2
flatpak install org.localsend.localsend_app
flatpak install org.tenacityaudio.Tenacity
flatpak install sh.ppy.osu
exit

# rust sdk
xbps-install -y rustup
su mig
rustup-init
exit
