#!/bin/bash

if [ ! -d ./themes/$1 ]; then 
	echo "theme $1 does not exist"
	exit
fi

if [ -f ./current_theme ]; then

	current_theme=$(cat current_theme)
	stow --delete . -d themes/$current_theme -t ~/ --dotfiles
fi

stow . -d themes/$1 -t ~/ --dotfiles

echo $1 > current_theme
