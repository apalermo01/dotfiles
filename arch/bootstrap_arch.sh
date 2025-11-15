#!/usr/bin/env bash

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

bash ~/arch_update.sh

pipx ensurepath
source ~/.bashrc
pipx install git+https://github.com/apalermo01/ricer.git -f
if [ ! -d ~/.config/ricer/ ]; then
    mkdir -p ~/.config/ricer
    curl -sL https://raw.githubusercontent.com/apalermo01/dotfiles/refs/heads/main/templates/global.yml -o ~/.config/ricer/ricer-global.yml
fi

echo "installing cargo"
curl https://sh.rustup.rs -sSf | sh

echo "installing brave"
curl -fsS https://dl.brave.com/install.sh | sh

echo "generating ssh keys"
make_ssh

echo "Package installation complete"
echo "Change shell to zsh using chsh -s /bin/zsh"
echo ""
