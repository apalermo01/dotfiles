echo "Installing oh my zsh..."



CHSH="no"

RUNZSH="no"

KEEP_ZSHRC="yes"



if ! [[ -d "${HOME}/.oh-my-zsh" ]]; then



    read -rp "oh my zsh not installed. Run the installer script? [y/n]" ins



    if [[ "${ins}" =~ ^([yY][eE][sS]|[yY])$ ]]; then



        wget -O- -q https://install.ohmyz.sh/

        read -rp "Please inspect the installer script above. Press any key to continue"



        sh -c "$(curl -fsSL https://install.ohmyz.sh/)"



    fi



fi





echo "installing catppuccin theme..."



if ! [[ -d "${HOME}/.zsh/catppuccin-zsh" ]]; then



    git clone https://github.com/JannoTjarks/catppuccin-zsh.git "${HOME}/.zsh/catppuccin-zsh"

    mkdir ~/.oh-my-zsh/themes/catppuccin-flavors



fi

ln -f $HOME/.zsh/catppuccin-zsh/catppuccin.zsh-theme ~/.oh-my-zsh/themes/

ln -f $HOME/.zsh/catppuccin-zsh/catppuccin-flavors/* ~/.oh-my-zsh/themes/catppuccin-flavors
