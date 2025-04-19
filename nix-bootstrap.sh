#!usr/bin/env sh

function clone_dotfiles {
    mkdir -p ~/Documents/git
    cd ~/Documents/git
    echo "cloning dotfiles repo"
    nix-shell -p git --command "
        git clone git@github.com:apalermo01/dotfiles
    "
    cd dotfiles
    nix-shell -p git --command "
        git submodule update --init
    "
    echo "Dotfiles repo has been cloned and installed."

}

function init_system {
    echo "available hosts: $(ls nix/hosts)"
    read -p "Select host: " hostname
    if [[ ! -d ~/Documents/git/dotfiles/nix/hosts/$hostname ]]; then 
        echo "Host $hostname does not exist. Exiting..."
        exit
    fi

    echo "Installing hardware configuration..."
    if [[ -d /etc/nixos/hardware-configuration.nix ]]; then 
        sudo cp /etc/nixos/hardware-configuration.nix ~/Documents/git/dotfiles/nix/hosts/$hostname/hardware-configuration.nix
        sudo mv /etc/nixos /etc/nixos.bak
    else 
        echo "Default hardware configuration not found. It may have already been initialized."
    fi
    echo "Installing system..."
    sudo nixos-rebuild switch --flake .#$hostname
}

read -p "This script expects an ssh key for git to be established. Continue (y/n)?" choice
case "$choice" in 
    y|Y) echo "Continuing..." ;;
    *) echo "exiting" 
       exit;;
esac

if [[ ! -d ~/Documents/git/dotfiles ]]; then
    clone_dotfiles
fi

read -p "Init system (y/n)?" choice
case "$choice" in 
    y|Y) init_system ;;
    *) echo "continuing";;
esac

read -p "Install restic backup system (y/n)?" choice
case "$choice" in 
    y|Y) bash ./scripts/install_backup.sh ;;
    *) echo "continuing";;
esac

read -p "Install theme builder (y/n)?" choice
case "$choice" in 
    y|Y) bash ./scripts/install_theme_builder.sh ;;
    *) echo "continuing";;
esac

read -p "Build themes (y/n)?" choice
case "$choice" in 
    y|Y) 
        nix-shell --command "cd theme-builder && bash migrate_theme_to_dotfiles.sh all"
        cd ~/Documents/git/dotfiles/
        git checkout main
        git merge dev
    *) echo "continuing";;
esac

echo "System fully initialized"
