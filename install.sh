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
su mig -c 'flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo'
# reboot

# fonts
xbps-install -y font-firacode nerd-fonts google-fonts-ttf cantarell-fonts

# visual session
su mig -c 'git clone --depth=1 https://github.com/migue07juegos/void-packages.git -b no-merge'
su mig -c 'cd void-packages'
su mig -c './xbps-src binary-bootstrap'
su mig -c 'xgensum -fi niri'
su mig -c './xbps-src pkg niri'
su mig -c './xbps-src pkg swayosd'
su mig -c './xbps-src pkg an-anime-game-launcher'
su mig -c './xbps-src pkg yazi'
su mig -c 'xi -y niri'
su mig -c 'xi -y swayosd'
su mig -c 'xi -y an-anime-game-launcher'
su mig -c 'xi -y yazi'
su mig -c 'cd /home/mig'
su mig -c 'rm -rfd void-packages/'
su mig -c 'git clone --depth=1 https://github.com/migue07juegos/void-packages.git -b kickoff'
su mig -c 'cd void-packages'
su mig -c './xbps-src binary-bootstrap'
su mig -c './xbps-src pkg kickoff'
su mig -c 'xi -y kickoff'
su mig -c 'cd /home/mig'
su mig -c 'rm -rfd void-packages/'

# apps
xbps-install -y foot neovim mpv thunar firefox keepassxc obs qalculate-gtk PrismLauncher transmission-gtk
xbps-install -y ffmpeg waybar nomacs kimageformats libreoffice xdg-utils dragon npm lua54

# flatpak apps
su mig -c 'flatpak install com.github.tchx84.Flatseal'
su mig -c 'flatpak install flathub com.valvesoftware.Steam'
su mig -c 'flatpak install flathub com.heroicgameslauncher.hgl'
su mig -c 'flatpak install com.github.iwalton3.jellyfin-media-player'
su mig -c 'flatpak install net.epson.epsonscan2'
su mig -c 'flatpak install org.localsend.localsend_app'
su mig -c 'flatpak install org.tenacityaudio.Tenacity'
su mig -c 'flatpak install sh.ppy.osu'

# rust sdk
xbps-install -y rustup
su mig -c 'rustup-init'
