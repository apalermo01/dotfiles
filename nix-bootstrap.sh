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
    if [[ ! -d $HOME/Documents/git/dotfiles/nix/hosts/$hostname ]]; then 
        echo "Host $hostname does not exist. Exiting..."
        exit
    fi

    echo "Installing hardware configuration..."
    if [[ -f /etc/nixos/hardware-configuration.nix ]]; then 
        sudo cp /etc/nixos/hardware-configuration.nix ~/Documents/git/dotfiles/nix/hosts/$hostname/hardware-configuration.nix
        echo "copied hardware configuration to hosts directory. nix/hosts/${hostname} = "
        cat ~/Documents/git/dotfiles/nix/hosts/$hostname/hardware-configuration.nix
        sudo mv /etc/nixos /etc/nixos.bak

    else 
        echo "Default hardware configuration not found. It may have already been initialized."
    fi 

    mapfile -t used_uuids < <(grep -o 'by-uuid/[A-Fa-f0-9\-]\+' "~/Documents/git/dotfiles/nix/${hostname}/hardware-configuration.nix" | sed 's/by-uuid\///')

    for uuid in "${used_uuids[@]}"; do
        if ! blkid | grep -q "$uuid"; then
            echo "❌ UUID $uuid not found on system. Hardware config likely invalid."
            echo "🛑 Aborting to avoid boot failure."
            exit 1
        fi
    done

    echo "✅ Hardware config validated. Press any key to continue install"
    read -p "..." _
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
