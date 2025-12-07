#!/usr/bin/env bash 

recent_dir=$(pwd)

if [[ ! -d ~/.local/share/themes/Midnight ]]; then
    mkdir -p ~/tmp-download-midnight 
    cd ~/tmp-download-midnight

    curl -sL https://github.com/i-mint/midnight/archive/refs/heads/master.zip -o midnight.zip
    unzip midnight.zip midnight-master/Midnight*
    mv midnight-master/* ~/.local/share/themes/
    cd $recent_dir 

    rm -r ~/tmp-download-midnight/
fi


gsettings set org.gnome.desktop.interface gtk-theme ""
gsettings set org.gnome.desktop.interface gtk-theme "Midnight-Red"

