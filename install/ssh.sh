#!/usr/bin/env bash 

make_ssh() {
    ssh-keygen -t ed25519 -f ~/.ssh/$1
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/$1

    case $1 in 
        github)
            sed -i '/github/d' ~/.ssh/config
            cat <<- EOF >> ~/.ssh/config
                Host github.com 
                    Hostname github.com 
                    IdentityFile ~/.ssh/github
EOF
        ;;
        gitlab)
            sed -i '/gitlab/d' ~/.ssh/config
            cat <<- EOF >> ~/.ssh/config
                Host gitlab.com 
                    Hostname gitlab.com 
                    IdentityFile ~/.ssh/gitlab
EOF
        ;;
    esac
}

make_ssh
