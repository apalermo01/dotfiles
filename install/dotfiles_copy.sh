#!/usr/bin/env bash

set -e

confirm() {
    read -r -p "$1 [y/n]: " ans
    [[ $ans =~ ^[Yy]$ ]]
}

curl -sL https://github.com/apalermo01/dotfiles/archive/refs/heads/main.zip -o ~/dotfiles.zip

unzip -d ~/Documents/dotfiles ~/dotfiles.zip

echo "dotfiles copied to ~/Documents/dotfiles"

if command -v ricer; then
    confirm "run ricer? " && {
        ricer switch
    }
fi
