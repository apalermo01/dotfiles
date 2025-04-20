#!/usr/bin/env sh

# TODO: run this or set up the nix shell depending on os
# cd theme-builder
# python -m venv env
# source ./env/bin/activate && pip install -r requirements.txt

# add theme builder repo
if [[ ! -d ./theme-builder/modules ]]; then
    git submodule init
    git submodule update
fi
# copy over wallpapers
if [[ ! -d $HOME/Pictures/wallpapers ]]; then
    echo "Creating wallpapers directory... "
    mkdir $HOME/Pictures/wallpapers/
fi

echo "Copying wallpapers to home directory..."
cp ./theme-builder/wallpapers/* $HOME/Pictures/wallpapers/ --verbose

echo "Copying scripts to home directory..."
cp ./theme-builder/scripts/* $HOME/ --verbose

mkdir -p ~/.config/polybar
cp ./theme-builder/scripts/i3_polybar_start.sh ~/.config/polybar/i3_polybar_start.sh

# fisher
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
