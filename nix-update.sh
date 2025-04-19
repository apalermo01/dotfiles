#!/usr/bin/env bash

echo "available hosts: $(ls nix/hosts)"
read -p "Select host: " hostname
if [[ ! -d ~/Documents/git/dotfiles/nix/hosts/$hostname ]]; then 
    echo "Host $hostname does not exist. Exiting..."
    exit
fi
echo "Installing system..."
git add flake.nix
git add flake.lock
git add nix/*
git commit -m "commit from nix system update"
git push
sudo nixos-rebuild switch --flake .#$hostname
