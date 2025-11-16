#!/usr/bin/env bash
set -euo pipefail
# IFS=$'\n\t'

# util functions
confirm() { read -r -p "$1 [y/n]: " ans; [[ $ans =~ ^[Yy]$ ]]; }

# bootstrap based on os / system setup # 
# Run this if on a non-nix system using the nix package manager
bootstrap_nix_package_manager() {
    local init_system install_multi

    init_system=$(ps --no-headers -o comm 1)


    if [[ $init_system == "systemd" ]]; then
        read -r -p "Install nix for single user [s] or multi-user [m]? " install_multi
    else
        echo "Systemd not detected, defaulting to a single user install"
        install_multi=s
    fi

    if [[ "$install_multi" == "s" ]]; then
        sh <(curl -L https://nixos.org/nix/install) --no-daemon
        . /home/user/.nix-profile/etc/profile.d/nix.sh
    elif [[ "$install_multi" == "m" ]]; then
        sh <(curl -L https://nixos.org/nix/install) --daemon
    else
        echo "invalid option $install_multi"
        exit 1
    fi
}

# set up nixos
bootstrap_nix() {
    if [[ ! -d $HOME/Documents/git/dotfiles ]]; then 
        clone_dotfiles
    fi

    cd $HOME/Documents/git/dotfiles/

    echo "current dir = $(pwd)"
    echo "🖥  NixOS detected."
    echo "Available NixOS hosts  desktop"
    read -r -p "Select host to switch to: " hostname

    if [[ ! -d "$HOME/Documents/git/dotfiles/nix/hosts/$hostname" ]]; then
        echo "Host '$hostname' does not exist.  Aborting."; exit 1
    fi

    echo "Copying current hardware-configuration.nix into repo…"
    sudo cp /etc/nixos/hardware-configuration.nix \
        "$HOME/Documents/git/dotfiles/nix/hosts/$hostname/"

    echo "Rebuilding system for '$hostname'…"
    sudo nixos-rebuild switch --flake ".#$hostname"
    return

    # auto-detect WSL
    if grep -qi microsoft /proc/version; then
        profile=wsl
        echo "🐧  WSL environment detected – using homeConfigurations.$profile"
    else
        echo "Available Home-Manager profiles:  gc-workstation"
        read -r -p "Select profile: " hm_profile
        profile=$hm_profile
    fi

    if [[ ! -d "$HOME/Documents/git/dotfiles/nix/hosts/$profile" ]]; then
        echo "Profile '$profile' does not exist.  Aborting."; exit 1
    fi

    echo "Activating Home-Manager profile '$profile'…"
    nix --extra-experimental-features nix-command \
        --extra-experimental-features flakes \
        run ".#homeConfigurations.${profile}.activationPackage"
}

bootstrap_arch() {
    bash <(curl -sL https://raw.githubusercontent.com/apalermo01/dotfiles/refs/heads/main/arch/bootstrap_arch.sh)

}
init_system() {
    local hostname os_id profile

    os_id=$(grep -E '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    
    case $os_id in 
        nixos)
            bootstrap_nix
            ;;
        arch) 
            bash bootstrap_arch
            ;;
        *) 
            echo "ERROR: unknown os_id: $os_id"
            exit 1
            ;;
    esac
}

if ! command -v nix >/dev/null; then
    if confirm "Nix package manager not found. Install?"; then bootstrap_nix_package_manager; fi
fi

confirm "Is the SSH key for github set up and agent loaded?" || exit 0

confirm "Run host initialization?" && init_system

confirm "Install restic backup?" && nix develop --command "./scripts/install_backup.sh"

confirm "Make ssh key for github?" && make_ssh "github"
confirm "Make ssh key for gitlab?" && make_ssh "gitlab"

echo "System fully initialized"
