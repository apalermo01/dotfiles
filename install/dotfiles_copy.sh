#!/usr/bin/env bash

curl -sL https://github.com/apalermo01/dotfiles/archive/refs/heads/main.zip -o ~/dotfiles.zip 

unzip -d ~/Documents/dotfiles ~/dotfiles.zip

echo "dotfiles copied to ~/Documents/dotfiles"
