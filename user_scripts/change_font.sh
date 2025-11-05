#!/usr/bin/env bash 

if [[ $1 = '-h' ]]; then 
    echo "change to any mono font"
    exit 0
fi

choice=$(fc-list | grep -i "mono" | rev | cut -d "/" -f -1 | rev | cut -d "." -f -1 | cut -d "-" -f -1 | sort | uniq | rofi -dmenu -i -p "select a font: ")

if [ -z "${choice}" ]; then 
    notify-send "empty selection, canceling"
    exit 0
fi

cfg="$HOME/Documents/git/dotfiles/templates/global.yml"
sed -i "s/^font:.*/font: ${choice}/" $cfg

current_theme=$(cat "$HOME/Documents/git/dotfiles/current_theme")

notify-send "Font switched to ${choice}. Reloading theme ${current_theme} in 3 seconds"
sleep 3
ricer switch --theme $current_theme
