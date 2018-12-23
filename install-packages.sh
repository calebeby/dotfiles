#!/usr/bin/env bash

sudo echo "Update"
sudo dnf update

echo "Networking"
sudo dnf install NetworkManager NetworkManager-tui network-manager-applet

echo "Audio"
sudo dnf install volumeicon

echo "i3"

dnf config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_29/home:manuelschneid3r.repo
sudo dnf install i3 i3lock albert

echo "Terminal"
sudo dnf install sakura neovim fish

if [[ $SHELL != *"fish"* ]]; then
  echo "Changing shell to fish"
  chsh -s $(which fish)
fi

echo "Uninstall Gnome"
sudo dnf remove "gnome" "libreoffice-*"

echo "Themes and icons"
sudo dnf install lxappearance arc-theme paper-icon-theme

echo "Applications"
sudo dnf install gimp audacity blender

sudo dnf install redshift redshift-gtk

echo "Programming"
sudo dnf install nodejs python3
pip3 install --user neovim
pip2 install --user neovim
npm i -g neovim
