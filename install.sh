#! /bin/bash

#  TODO 
#   Refactor code
#   User selection of cp interactiveness
#   Selection of themes with multiple choice
#   Theme Rofi


homedir="`eval echo ~$USER`"

echo "Starting install"

echo "Copying GTK Theme"
if [[ !(-d ~/.themes) ]]
then
    mkdir ~/.themes
fi
cp -ri ./.themes/* ~/.themes/

echo "Copying Icon Theme"
cp -ri ./.icons/* ~/.icons/

echo "Copying rofi theme"
if [[ !(-d ~/.config/rofi) ]]
then
    mkdir ~/.config/rofi
fi
cp -ri ./.config/rofi ~/.config/rofi

echo "Copying .Xresources"
cp -i ./.Xresources ~/

echo "Setting GTK Theme & Icon Theme"
echo "Theme: `cat ./.config/gtk-3.0/settings.ini | grep "gtk-theme-name" | grep -o "[^=]*$"`"
echo "Icons: `cat ./.config/gtk-3.0/settings.ini | grep "gtk-icon-theme-name" | grep -o "[^=]*$"`"
cp -ri ./.config/gtk-3.0 ~/.config

echo "Copying wallpaper"
if [[ !(-d ~/Pictures/Wallpapers) ]]
then
    mkdir ~/Pictures/Wallpapers
fi
cp -ri wallpaper/* ~/Pictures/Wallpapers/

echo "Setting wallpaper through Nitrogen"
wallpaper="`ls ./wallpaper | awk '{print $1}'`"
echo "Wallpaper: $wallpaper"
echo "[xin_-1]
file=$homedir/Pictures/Wallpapers/$wallpaper
mode=5
bgcolor=#002a36" >> ./.config/nitrogen/bg-saved.cfg
cp -i ./.config/nitrogen/bg-saved.cfg ~/.config/nitrogen/bg-saved.cfg

echo "Setting Compton transparency"
cp -i ./.config/compton.conf ~/.config/

echo "Setting Polybar theme"
cp -ri ./.config/polybar ~/.config/

echo "Setting i3 configurations"
cp -ri ./.i3 ~/

i3-nagbar -t warning -m 'Restart i3 to load the changes' -b 'Yes, exit i3' 'i3-msg exit'

