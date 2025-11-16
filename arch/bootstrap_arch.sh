#!/usr/bin/env bash

confirm() {
    read -r -p "$1 [y/n]: " ans
    [[ $ans =~ ^[Yy]$ ]]
}

make_ssh() {
    ssh-keygen -t ed25519 -f ~/.ssh/$1
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/$1

    case $1 in
    github)
        cat <<-EOF >~/.ssh/config
                Host github.com 
                    Hostname github.com 
                    IdentityFile ~/.ssh/github
EOF
        ;;
    gitlab)
        cat <<-EOF >~/.ssh/config
                Host gitlab.com 
                    Hostname gitlab.com 
                    IdentityFile ~/.ssh/gitlab
EOF
        ;;
    esac
}

if [[ $EUID -eq 0 ]]; then
    echo "running arch bootstrap in root mode"

    read -p "adding user to sudoers file. What is the username? " user
    if ! id $user >/dev/null 2>&1; then
        echo "user $user not found. Exiting..."
        exit 1
    fi

    if ! grep -q $user /etc/sudoers; then
        echo "$user ALL=(ALL:ALL) ALL" >>/etc/sudoers
    else
        echo "$user is already in the sudoers file"
    fi

    read -n1 -srp "downloading package list and update script from dotfiles repo. Press any key to continue..."

    curl -sL https://raw.githubusercontent.com/apalermo01/dotfiles/refs/heads/main/arch/packages.list -o ~/packages.list

    curl -sL https://raw.githubusercontent.com/apalermo01/dotfiles/refs/heads/main/arch/arch_update.sh -o ~/arch_update.sh

    echo "Installing these packages:"
    cat ~/packages.list

    confirm "press y to continue... "

    sudo pacman -Syu || {
        echo "You may not be sudo"
        echo "login as root and run: "
        echo "sudo usermod -a -G wheel <your user>"
        echo ""
        echo "once that is done, open /etc/sudoers and "
        echo "uncomment the line starting with %wheel ALL="
    }

    bash ~/arch_update.sh ~/packages.list

    echo "cleaning up package list and install script"
    rm ~/packages.list ~/arch_update.sh


    echo "bash <(curl -sL raw.githubusercontent.com/apalermo01/dotfiles/refs/heads/main/bootstrap.sh)" >/home/$user/runme.sh

    echo "Root bootstrap is complete. To continue, log in as the normal user and re-run the bootstrap script. To help, I put the command in /home/$user/runme.sh"

else
    echo "Bootstrap script is being run as a normal user. Skipping steps that require root..."
fi

if [[ $EUID -ne 0 ]]; then
    if ! command -v ricer; then
        echo "installing ricer..."
        pipx install git+https://github.com/apalermo01/ricer.git -f
        pipx ensurepath
        source ~/.bashrc
        mkdir -p ~/.config/ricer
        curl -sL https://raw.githubusercontent.com/apalermo01/dotfiles/refs/heads/main/templates/global.yml -o ~/.config/ricer/ricer-global.yml
    fi

    read -n1 -srp "installing yay. Press any key to continue..."
    mkdir -p ~/tmp/yay
    sudo pacman -S --needed git base-devel 
    git clone https://aur.archlinux.org/yay.git ~/tmp/yay
    cd ~/tmp/yay
    makepkg -si

    cd 
    yes | rm -r ~/tmp

    echo "installing cargo"
    curl https://sh.rustup.rs -sSf | sh

    echo "installing brave"
    curl -fsS https://dl.brave.com/install.sh | sh

    echo "generating ssh keys"

    echo "Package installation complete"
    echo "Change shell to zsh using chsh -s /bin/zsh"

    if [[ ! -e ~/.ssh/github ]]; then
        confirm "Make ssh key for github?" && make_ssh "github"
    fi

    if [[ ! -e ~/.ssh/gitlab ]]; then
        confirm "Make ssh key for gitlab?" && make_ssh "gitlab"
    fi

    confirm "overwrite /etc/greetd/config.toml?" && {
        sudo cat <<-EOF >/etc/greetd/config.toml
[terminal]
vt = 1

[default_session]
command = "tuigreet --cmd startx"
user = "greeter"
EOF
    }

    echo "enabling greetd.service"
    sudo systemctl enable greetd.service

    confirm "write xinitrc to start i3? " && {
        cat <<-EOF >~/.xinitrc
exec i3
EOF
    }
    confirm "download copy of dotfiles repo? " && {
        bash <(curl -sL https://raw.githubusercontent.com/apalermo01/dotfiles/refs/heads/main/install/dotfiles_copy.sh)
    }
fi
