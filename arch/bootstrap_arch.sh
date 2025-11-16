#!/usr/bin/env bash

confirm() { read -r -p "$1 [y/n]: " ans; [[ $ans =~ ^[Yy]$ ]]; }

make_ssh() {
    ssh-keygen -t ed25519 -f ~/.ssh/$1
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/$1

    case $1 in 
        github)
            cat <<- EOF > ~/.ssh/config
                Host github.com 
                    Hostname github.com 
                    IdentityFile ~/.ssh/github
EOF
        ;;
        gitlab)
            cat <<- EOF > ~/.ssh/config
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
    if grep -q $user /etc/sudoers; then
        echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers
    else
        echo "$user is already in the sudoers file"
    fi

    echo "downloading package list and update script from dotfiles repo"
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
else
    echo "bootstrap script is being run as root user. To complete the remaining steps, log out and re-run this script as a normal user."
fi 

if [[ $EUID -ne 0 ]]; then
    if [ ! -d ~/.config/ricer/ ]; then
        echo "installing ricer..."
        pipx install git+https://github.com/apalermo01/ricer.git -f
        mkdir -p ~/.config/ricer
        curl -sL https://raw.githubusercontent.com/apalermo01/dotfiles/refs/heads/main/templates/global.yml -o ~/.config/ricer/ricer-global.yml
    fi
    echo "installing cargo"
    curl https://sh.rustup.rs -sSf | sh

    echo "installing brave"
    curl -fsS https://dl.brave.com/install.sh | sh

    echo "generating ssh keys"
    make_ssh
else 
    echo "The remaining installations must be done by the user. Please re-run this script outide of root."

fi

echo "Package installation complete"
echo "Change shell to zsh using chsh -s /bin/zsh"
