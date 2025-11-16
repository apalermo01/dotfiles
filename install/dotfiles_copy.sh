#!/usr/bin/env bash

set -e

confirm() {
    read -r -p "$1 [y/n]: " ans
    [[ $ans =~ ^[Yy]$ ]]
}

curl -sL https://github.com/apalermo01/dotfiles/archive/refs/heads/main.zip -o ~/dotfiles.zip
unzip -d ~/Documents/ ~/dotfiles.zip


sed -i 's|Documents/git/dotfiles|Documents/dotfiles-main|g' ~/Documents/dotfiles-main/templates/global.yml
sed -i 's|Documents/git/dotfiles|Documents/dotfiles-main|g' ~/Documents/dotfiles-main/scripts/switch_theme.sh
sed -i 's|Documents/git/dotfiles|Documents/dotfiles-main|g' ~/.config/ricer/ricer-global.yml

echo "dotfiles copied to ~/Documents/dotfiles-main"

if command -v ricer; then
    confirm "run ricer? " && {
        ricer switch --root ~/Documents/dotfiles-main/
    }
fi
