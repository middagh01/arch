#!/bin/bash
echo "actualizando sistema...."
if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta=$(pwd)



# Actualizando el sistema
sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm bspwm sxhkd polybar rofi picom feh zsh neofetch lsd bat zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete


sudo pacman -S --noconfirm base-devel git vim xcb-util xcb-util-wm xcb-util-keysyms xcb-util-xrm libxinerama alsa-lib
sudo pacman -S --noconfirm cmake pkg-config python-sphinx cairo xcb-util xcb-util-wm xcb-util-keysyms xcb-util-xrm xcb-util-cursor alsa-lib libpulse jsoncpp libmpdclient libuv libnl bspwm sxhkd polybar rofi picom feh dunst alacritty ttf-font-awesome
sudo pacman -S --noconfirm meson libxext libxcb libpixman dbus libconfig mesa pcre evdev uthash libx11
sudo pacman -S  -noconfirm feh flameshot scrub zsh rofi xclip bat mlocate neofetch wmname acpi bspwm sxhkd imagemagick ranger kitty

mkdir ~/github
mkdir ~/repos

cd ~/repos
git clone https://aur.archlinux.org/yay.git
cd yay;makepkg -si --noconfirm


# Descargar Repositorios Necesarios

cd ~/github
git clone --recursive https://github.com/polybar/polybar
git clone https://github.com/ibhagwan/picom.git

# Instalando Polybar

cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install

# Instalando Picom

cd ~/github/picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

# Instalando p10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Instalando p10k root

sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.powerlevel10k

# Configuramos el tema Nord de Rofi:

mkdir -p ~/.config/rofi/themes
cp $ruta/rofi/nord.rasi ~/.config/rofi/themes/

# Instando lsd

#sudo dpkg -i $ruta/lsd.deb

# Instalamos las HackNerdFonts

sudo cp -v $ruta/fonts/HNF/* /usr/local/share/fonts/

# Instalando Fuentes de Polybar

sudo cp -v $ruta/Config/polybar/fonts/* /usr/share/fonts/truetype/

# Instalando Wallpaper de S4vitar

mkdir ~/Wallpaper
cp -v $ruta/Wallpaper/* ~/Wallpaper
mkdir ~/ScreenShots

# Copiando Archivos de Configuración

cp -rv $ruta/Config/* ~/.config/
sudo cp -rv $ruta/kitty /opt/

# Kitty Root

sudo cp -rv $ruta/Config/kitty /root/.config/

# Copia de configuracion de .p10k.zsh y .zshrc

rm -rf ~/.zshrc
cp -v $ruta/.zshrc ~/.zshrc

cp -v $ruta/.p10k.zsh ~/.p10k.zsh
sudo cp -v $ruta/.p10k.zsh-root /root/.p10k.zsh

# Script

sudo cp -v $ruta/scripts/whichSystem.py /usr/local/bin/
sudo cp -v $ruta/scripts/screenshot /usr/local/bin/

# Plugins ZSH

sudo mkdir /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

# Cambiando de SHELL a zsh

chsh -s /usr/bin/zsh
sudo usermod --shell /usr/bin/zsh root
sudo ln -s -fv ~/.zshrc /root/.zshrc

# Asignamos Permisos a los Scritps

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/bin/ethernet_status.sh
chmod +x ~/.config/bin/htb_status.sh
chmod +x ~/.config/bin/htb_target.sh
chmod +x ~/.config/polybar/launch.sh
sudo chmod +x /usr/local/bin/whichSystem.py

# Configuramos el Tema de Rofi

rofi-theme-selector

# Removiendo Repositorio

rm -rf ~/github
rm -rf $ruta

# Mensaje de Instalado

notify-send "BSPWM INSTALADO"
