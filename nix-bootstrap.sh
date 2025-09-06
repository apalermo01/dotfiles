#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

confirm() { read -r -p "$1 [y/n]: " ans; [[ $ans =~ ^[Yy]$ ]]; }

install_nix() {
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

clone_dotfiles() {
    git_root="$HOME/Documents/git"
    mkdir -p "$git_root"

    if command -v nix-shell >/dev/null; then
        nix-shell -p git --command "
            cd $git_root && git clone git@github.com:apalermo01/dotfiles && cd $git_root/dotfiles && git submodule update --init
        "
    else
        ( git clone git@github.com:apalermo01/dotfiles "$git_root/dotfiles"
          cd "$git_root/dotfiles" && git submodule update --init )
    fi

    cd $git_root/dotfiles

    echo "Dotfiles repo has been cloned and installed."

}

init_system() {
    local hostname os_id profile

    os_id=$(grep -E '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    
    if [[ "$os_id" == nixos ]]; then
        echo "🖥  NixOS detected."
        echo "Available NixOS hosts:  headless  desktop"
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
    fi

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

if ! command -v nix >/dev/null; then
    if confirm "Nix not found. Install?"; then install_nix; fi
fi

confirm "Is the SSH key for github set up and agent loaded?" || exit 0

if [[ ! -d $HOME/Documents/git/dotfiles ]]; then 
    clone_dotfiles
fi

cd $HOME/Documents/git/dotfiles/
echo "current dir = $(pwd)"
confirm "Run host initialization? (this is for both home manager and nixos)" && init_system

confirm "Install restic backup?" && nix develop --command "./scripts/install_backup.sh"

# confirm "Install theme builder?" && nix develop --command "./scripts/remove_targets.sh" && nix develop --command "./scripts/install_theme_builder.sh"
# if confirm "Build themes now?"; then
#   cd "$HOME/Documents/git/dotfiles"
#   nix --extra-experimental-features 'nix-command flakes' develop .#default \
#     --command bash -c 'cd theme-builder && source master_font.sh && bash migrate_theme_to_dotfiles.sh all'
# fi

echo "System fully initialized"
