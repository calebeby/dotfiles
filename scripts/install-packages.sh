#!/usr/bin/env bash

sudo echo "Update"
sudo dnf update

echo "Networking"
sudo dnf install NetworkManager NetworkManager-tui network-manager-applet

echo "Misc"
sudo dnf install blueman nautilus

echo "Games"
sudo dnf install neverball supertuxkart supertux extremetuxracer

echo "Fingerprint"

sudo dnf install fprintd fprintd-pam

echo "Display Manager"

sudo dnf install gtk4 gtk3 lightdm lightdm-gtk lightdm-gtk-settings arc-theme numix-icon-theme grim slurp wl-clipboard

echo "sway"

sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:/manuelschneid3r/Fedora_36/home:manuelschneid3r.repo
sudo dnf install sway swaylock albert brightnessctl dunst

echo "Terminal"
# util-linux-user provides chsh
# gcc-c++ is needed for neovim treesitter
sudo dnf install kitty neovim fish util-linux-user gcc-c++

if [[ $SHELL != *"fish"* ]]; then
  echo "Changing shell to fish"
  chsh -s $(which fish)
fi

echo "Battery stuff"
sudo dnf install acpi tlp tlp-rdw

echo "Applications"
sudo dnf install gimp audacity inkscape blender

sudo dnf install redshift redshift-gtk

echo "Programming"
# moreutils for vidir
# perl for rust openssl compilation
sudo dnf install nodejs python3 ripgrep p7zip bat git-delta fd-find moreutils perl

echo "fonts"

sudo dnf install fira-code-fonts adobe-source-code-pro-fonts google-noto-emoji-color-fonts
