#!/usr/bin/env bash

# install script for wsl systems

set -euo pipefail

sudo apt install software-properties-common
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


install_datagrip() {
  local install_dir="/opt/datagrip"
  local symlink_path="/usr/local/bin/datagrip"
  local tmp_tar="/tmp/datagrip.tar.gz"

  echo "Fetching DataGrip..."
  local url=$(curl -s "https://data.services.jetbrains.com/products/releases?code=DG&latest=true&type=release" | \
    grep -oP '"linux":\s*{\s*"link":\s*"\K[^"]+')

  if [[ -z "$url" ]]; then
    echo "Failed to get download URL"
    return 1
  fi

  curl -L "$url" -o "$tmp_tar"
  sudo mkdir -p "$install_dir"
  sudo tar -xzf "$tmp_tar" --strip-components=1 -C "$install_dir"
  sudo ln -sf "$install_dir/bin/datagrip.sh" "$symlink_path"
  rm "$tmp_tar"
  echo "DataGrip installed. Use: datagrip"
}

install_go() {
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt update
    sudo apt install golang-1.24
    sudo ln -s /usr/lib/go-1.24/bin/go /usr/local/bin/go
}

# Rust tools repo
RUST_REPO_LIST="/etc/apt/sources.list.d/rust-tools.list"
if [ ! -f "$RUST_REPO_LIST" ]; then
  echo "Adding rust-tools APT repo"
  curl -fsSL https://apt.cli.rs/pubkey.asc | sudo tee /usr/share/keyrings/rust-tools.asc
  echo "deb [signed-by=/usr/share/keyrings/rust-tools.asc] https://apt.cli.rs/ rust-tools main" | sudo tee "$RUST_REPO_LIST"
fi

# Neovim unstable repo
if ! grep -q neovim-ppa /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
  sudo apt-add-repository -y ppa:neovim-ppa/unstable
fi

# Update repos
sudo apt update && sudo apt upgrade -y

# Fonts (manual download)
echo "🔤 Installing nerd fonts..."
# mkdir -p ~/.local/share/fonts
# cd ~/.local/share/fonts
FONT_LIST=(
  "TerminessTTF Nerd Font"
  "JetBrainsMono Nerd Font"
  "Iosevka Nerd Font"
  "FiraCode Nerd Font"
  "Hack Nerd Font"
)

for font in "${FONT_LIST[@]}"; do
  if ! fc-list | grep -i "$font" &> /dev/null; then
    echo "You may need to manually install: $font"
    # Optionally script download from nerdfonts.com
  else
    echo "$font already installed"
  fi
done


# Install core APT packages
echo "📦 Installing APT packages..."
APT_PACKAGES=(
  cargo
  direnv
  zoxide
  bat
  tmux
  fish
  zsh
  neovim
  stow
  fzf
  git
  curl
  build-essential
  python3-pip
  fonts-firacode
  cmake
  pipx
)

for pkg in "${APT_PACKAGES[@]}"; do
  install_if_missing "$pkg"
done

echo "📦 Installing cargo packages..."
cargo_install_if_missing eza
# cargo_install_if_missing gitui
cargo_install_if_missing fastfetch
cargo_install_if_missing tealdeer
cargo_install_if_missing stylua
cargo_install_if_missing starship
cargo_install_if_missing ripgrep
cargo_install_if_missing fnm
cargo_install_if_missing git-delta

command -v datagrip || install_datagrip 

# oh-my-posh
# bash -s scripts/non_nix_installs/install_oh_my_posh.sh

pipx ensurepath 
pipx install git+http://github.com/apalermo01/ricer.git
