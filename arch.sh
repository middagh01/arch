#!/bin/bash
echo "actualizando sistema...."

#if [ "$(whoami)" == "root" ]; then
#    exit 1
#fi
#ruta=$(pwd)

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm bspwm sxhkd polybar rofi picom feh zsh neofetch

mkdir -p ~/.config/bspwm
mkdir -p ~/.config/sxhkd
mkdir -p ~/.config/polybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/picom

sudo pacman -S --noconfirm base-devel git vim xcb-util xcb-util-wm xcb-util-keysyms xcb-util-xrm libxinerama alsa-lib
sudo pacman -S --noconfirm cmake pkg-config python-sphinx cairo xcb-util xcb-util-wm xcb-util-keysyms xcb-util-xrm xcb-util-cursor alsa-lib libpulse jsoncpp libmpdclient libuv libnl bspwm sxhkd polybar rofi picom feh dunst alacritty ttf-font-awesome
sudo pacman -S --noconfirm meson libxext libxcb libpixman dbus libconfig mesa pcre evdev uthash libx11
sudo pacman -S  -noconfirm feh flameshot scrub zsh rofi xclip bat mlocate neofetch wmname acpi bspwm sxhkd imagemagick ranger kitty

mkdir ~/repos
cd ~/repos
git clone --recursive https://github.com/polybar/polybar
git clone https://github.com/ibhagwan/picom.git
#intalacion polybar
cd ~/repos/polybar
mkdir build ;cd build
cmake ..
make -j$(nproc)
sudo make install
