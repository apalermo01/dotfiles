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
    echo "Installing system..."
    sudo nixos-rebuild switch --flake .#vm
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

# installing theme builder
echo "Installing theme builder..."
bash ./scripts/install_theme_builder.sh

echo "Building themes..."
nix-shell --command "cd theme-builder && bash migrate_theme_to_dotfiles.sh all"
