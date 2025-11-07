#!/usr/bin/env bash

# install script for remote systems

set -euo pipefail

add_apt_repo_if_missing() {
    local repo="$1"
    local list_file="/etc/apt/sources.list.d/${2}.list"

    if ! grep -q "^deb .*${repo}" "$list_file" 2>/dev/null; then 
        echo "Adding apt repository: $repo"
        echo "deb $repo" | sudo tee "$list_file"
    else 
        echo "APT repository $repo already present"
    fi
}

install_if_missing() {
    local pkg="$1"
    if ! dpkg -s "$pkg" &> /dev/null; then 
        echo "Installing $pkg"
        sudo apt install -y "$pkg"
    else
        echo "$pkg is already installed"
    fi


install_if_missing() {
    local pkg="$1"
    if ! dpkg -s "$pkg" &> /dev/null; then 
        echo "Installing $pkg"
        sudo apt install -y "$pkg"
    else
        echo "$pkg is already installed"
    fi
}

cargo_install_if_missing() {
    local bin="$1"
    local crate="${2:-$1}"
    if ! command -v "$bin" &> /dev/null; then
        echo "Installing $crate via cargo"
        cargo install "$crate"
    else 
        echo "$bin is already installed"
    fi
}

# Neovim unstable repo
if ! grep -q neovim-ppa /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
  sudo apt-add-repository -y ppa:neovim-ppa/unstable
fi


# Update repos
sudo apt update && sudo apt upgrade -y

# Install core APT packages
echo "📦 Installing APT packages..."
APT_PACKAGES=(
  cargo
  direnv
  zoxide
  bat
  tmux
  zsh
  neovim
  stow
  fzf
  git
  curl
  build-essential
  python3-pip
  cmake
  pipx
)

for pkg in "${APT_PACKAGES[@]}"; do
  install_if_missing "$pkg"
done

echo "📦 Installing cargo packages..."
cargo_install_if_missing eza
cargo_install_if_missing fastfetch
cargo_install_if_missing tealdeer
cargo_install_if_missing stylua
cargo_install_if_missing starship
cargo_install_if_missing ripgrep
cargo_install_if_missing fnm
cargo_install_if_missing git-delta

pipx ensurepath 
pipx install git+http://github.com/apalermo01/ricer.git
