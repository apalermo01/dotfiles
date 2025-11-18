#!/usr/bin/env sh

set -euo pipefail

echo "available hosts:"
ls -1 nix/hosts
read -p "Select host: " hostname
if [[ ! -d ~/Documents/git/dotfiles/nix/hosts/$hostname ]]; then
    echo "Host $hostname does not exist. Exiting..."
    exit
fi

# echo "Cleaning up old Home Manager backups..."
# find "$HOME" -type f -name "*.hm-bak" | while IFS= read -r file; do
#
#     read -rp "Delete $file ? [y/N]: " answer </dev/tty
#
#     case "$answer" in [yY] | [yY][eE][sS])
#         rm -f "$file"
#         echo "Removed: $file"
#         ;;
#     *)
#         echo "Skipped: $file"
#         ;;
#     esac
# done
echo "Installing system..."

if grep -qi microsoft /proc/version; then
    echo "Detected wsl config, using Home Manager."
    nix run .#homeConfigurations.wsl.activationPackage
else
    echo "Detected NixOs system, using nixos-rebuild."
    sudo nixos-rebuild switch --flake .#$hostname --show-trace
fi

echo "Build succeeded, committing to git.."
git add flake.nix
git add flake.lock
git add nix/**/*.nix
git commit -m "commit from nix system update"
