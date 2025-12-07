#!/usr/bin/env bash


#install gtk theme

THEME_BUILD_DIR="${HOME}/tmp-adw-gtk3"
THEME_INSTALL_DIR="${HOME}/.local/share/themes"
TEMPLATE_DEFAULT_SCSS_PATH=/home/alex/Documents/git/dotfiles/themes/test_gtk/build/gtk/adw-gtk3.scss

current_path=$(pwd)

if [[ -z ${TEMPLATE_DEFAULT_SCSS_PATH+x} ]]; then
    echo "ERROR: template scss path is not set. Exiting"
    exit 1
fi

if [[ ! -d ${THEME_BUILD_DIR} ]]; then
    mkdir -p ${THEME_BUILD_DIR}
fi
cd ${THEME_BUILD_DIR}

curl -sL https://github.com/lassekongo83/adw-gtk3/archive/refs/heads/main.zip -o ./adw-gtk3.zip
unzip ./adw-gtk3.zip

cp ${TEMPLATE_DEFAULT_SCSS_PATH} ${THEME_BUILD_DIR}/adw-gtk3-main/src/sass/_defaults.scss

if [[ -d ${THEME_INSTALL_DIR}/adw-gtk3 ]]; then
    echo "backing up existing adw-gtk3 theme"
    mv ${THEME_INSTALL_DIR}/adw-gtk3 ${THEME_INSTALL_DIR}/adw-gtk3-bak
    mv ${THEME_INSTALL_DIR}/adw-gtk3-dark ${THEME_INSTALL_DIR}/adw-gtk3-dark-bak
fi

cd ${THEME_BUILD_DIR}/adw-gtk3-main
meson setup -Dprefix="${HOME}/.local" build
ninja -C build install



