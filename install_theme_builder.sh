#!/usr/bin/env sh

# TODO: run this or set up the nix shell depending on os
# cd theme-builder
# python -m venv env
# source ./env/bin/activate && pip install -r requirements.txt
#
# copy over wallpapers
if [[ ! -d $HOME/Pictures/wallpapers ]]; then
    echo "Creating wallpapers directory... "
    mkdir $HOME/Pictures/wallpapers/
fi

echo "Copying wallpapers to home directory..."
cp ./theme-builder/wallpapers/* $HOME/Pictures/wallpapers/ --verbose
