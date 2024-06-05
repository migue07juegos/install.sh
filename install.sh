#!/bin/bash
xbps-install -Syu
xbps-install -y wget xtools dbus elogind chrony cups nftables polkit 
ln -s /etc/sv/cups /var/service/
ln -s /etc/sv/elogind /var/service/
ln -s /etc/sv/chronyd /var/service/
ln -s /etc/sv/nftables /var/service/
ln -s /etc/sv/polkitd /var/service/
xbps-install -y pipewire pavucontrol flatpak

# gpu drivers
xbps-install -y mesa-dri vulkan-loader Vulkan-ValidationLayers mesa-vulkan-intel intel-video-accel
xbps-install -y void-repo-nonfree
xbps-install -Sy nvidia

# flatpak stuff
sudo -i -u mig bash << EOF
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
EOF
# reboot

# fonts
xbps-install -y font-firacode nerd-fonts google-fonts-ttf cantarell-fonts

# visual session
sudo -i -u mig bash << EOF
cd /home/mig
git clone --depth=1 https://github.com/migue07juegos/void-packages.git -b no-merge
cd void-packages
./xbps-src binary-bootstrap
xgensum -fi niri
./xbps-src pkg niri
./xbps-src pkg swayosd
./xbps-src pkg an-anime-game-launcher
./xbps-src pkg yazi
EOF
cd /home/mig/void-packages/
xi -y niri
xi -y swayosd
xi -y an-anime-game-launcher
xi -y yazi
cd /home/mig
rm -rfd void-packages/
sudo -i -u mig bash << EOF
cd /home/mig
git clone --depth=1 https://github.com/migue07juegos/void-packages.git -b kickoff
cd void-packages
./xbps-src binary-bootstrap
./xbps-src pkg kickoff
EOF
cd /home/mig/void-packages/
xi -y kickoff
cd /home/mig
rm -rfd void-packages/

# apps
xbps-install -y foot neovim mpv Thunar firefox keepassxc obs qalculate-gtk PrismLauncher transmission-gtk
xbps-install -y ffmpeg Waybar nomacs kimageformats libreoffice xdg-utils dragon npm lua rustup

# flatpak apps
sudo -i -u mig bash << EOF
flatpak install com.github.tchx84.Flatseal
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.heroicgameslauncher.hgl
flatpak install com.github.iwalton3.jellyfin-media-player
flatpak install net.epson.epsonscan2
flatpak install org.localsend.localsend_app
flatpak install org.tenacityaudio.Tenacity
flatpak install sh.ppy.osu
EOF

# configuration files
sudo -i -u mig bash << EOF
echo 'export PATH="$PATH:$HOME/.local/bin"' >> .bashrc
echo 'alias reboot="loginctl reboot"' >> .bashrc
echo 'alias poweroff="loginctl poweroff"' >> .bashrc
echo 'PS1="\[\e[0m\][\[\e[1;36m\]\u\[\e[0m\]@\[\e[1;36m\]\h\[\e[0m\] \W]\$ "' >> .bashrc
echo 'export GPG_TTY=$(tty)' >> .bashrc
echo 'export XDG_CONFIG_DIRS="$HOME/.config"'

cd
mkdir -p .local/bin

git clone --depth=1 https://github.com/migue07juegos/dotfiles.git
cd dotfiles
mv .local/bin/* /home/mig/.local/bin/
mv .config/* /home/mig/.config/
cd
rm -rfd dotfiles/
EOF
