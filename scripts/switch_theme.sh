#!/bin/bash

echo "====================================="
echo "==== Running switch theme script ===="
echo "====================================="

if [ ! -d ./themes/$1 ]; then 
	echo "theme $1 does not exist"
	exit
fi

if [ -f ./current_theme ]; then
	current_theme=$(cat current_theme)
    echo "un-stowing current theme: $current_theme"
	stow --delete . -d themes/$current_theme -t ~/ --dotfiles
    if [ $? -ne 0 ]; then
        echo "unstow failed, exiting"
        exit
    else    
        echo "unstow successful!"
    fi
fi

echo "stowing new theme: $1"
stow . -d themes/$1 -t ~/ --dotfiles

if [ $? -ne 0 ]; then
    echo "stow failed, exiting"
    exit
else 
    echo "stow successful!"
fi


echo "running theme install scripts"
if [ -d ./themes/$1/.config/theme_scripts/ ]; then
    for fname in $(ls ./themes/$1/.config/theme_scripts/ | sort); do
        script="./themes/$1/.config/theme_scripts/$fname"
        if [ -x "$script" ]; then
            echo "Executing $script"
            "$script"
        else
            echo "Skipping $script: not executable"
        fi
    done
else
    echo "no theme install scripts detected"
fi

echo $1 > current_theme

echo "copying user scripts"
cp ./theme-builder/scripts/* ~
