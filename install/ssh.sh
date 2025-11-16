#!/usr/bin/env bash

echo "generating ssh key $1"

ssh-keygen -t ed25519 -f ~/.ssh/$1
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    eval "$(ssh-agent -s)"
fi
ssh-add ~/.ssh/$1

case $1 in
github)
    sed -i '/github/d' ~/.ssh/config
    cat <<EOF >> ~/.ssh/config
Host github.com 
    HostName github.com 
    IdentityFile ~/.ssh/github
EOF
    ;;
gitlab)
    sed -i '/gitlab/d' ~/.ssh/config
    cat <<EOF >> ~/.ssh/config
Host gitlab.com 
    HostName gitlab.com 
    IdentityFile ~/.ssh/gitlab
EOF
    ;;
esac


chmod 600 ~/.ssh/config
