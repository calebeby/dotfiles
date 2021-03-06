#!/usr/bin/env bash

sudo echo "Update"
sudo dnf update

echo "Networking"
sudo dnf install NetworkManager NetworkManager-tui network-manager-applet

echo "Audio"
sudo dnf install volumeicon

echo "i3"

sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_29/home:manuelschneid3r.repo
sudo dnf install i3 i3lock albert

echo "Terminal"
sudo dnf install kitty neovim fish util-linux-user

if [[ $SHELL != *"fish"* ]]; then
  echo "Changing shell to fish"
  chsh -s $(which fish)
fi

echo "Battery stuff"
sudo dnf install acpi tlp tlp-rdw

echo "Themes and icons"
sudo dnf install lxappearance arc-theme paper-icon-theme

echo "Applications"
sudo dnf install gimp audacity blender

sudo dnf install redshift redshift-gtk gnome-screenshot

echo "Programming"
# moreutils for vidir
sudo dnf install nodejs python3 ripgrep aria2 p7zip bat git-delta fd-find moreutils httpie

echo "fonts"

sudo dnf install fira-code-fonts adobe-source-code-pro-fonts
