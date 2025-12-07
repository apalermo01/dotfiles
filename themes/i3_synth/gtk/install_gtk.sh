
# theme
THEME_DIR=${HOME}/.cache/GTK-sweet

if [[ ! -d $THEME_DIR ]]; then
    mkdir -p $THEME_DIR
    curl -sL https://github.com/EliverLara/Sweet/releases/download/v6.0/Sweet-Dark-v40.tar.xz -o ${THEME_DIR}/Sweet-Dark-v40.tar.xz

    tar -xvf ${THEME_DIR}/Sweet-Dark-v40.tar.xz -C ${THEME_DIR}
    rm ${THEME_DIR}/Sweet-Dark-v40.tar.xz
fi

cp -r ${THEME_DIR}/Sweet-Dark-v40 ~/.local/share/themes/

# icons
ICON_DIR=${HOME}/.cache/GTK-sweet-icons 
if [[ ! -d $ICON_DIR ]]; then
    mkdir -p $ICON_DIR
    curl -sL https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip -o ${ICON_DIR}/candy-icons.zip

    unzip ${ICON_DIR}/candy-icons.zip -d ${ICON_DIR}/candy-icons
    rm ${ICON_DIR}/candy-icons.zip

    mv ${ICON_DIR}/candy-icons/candy-icons-master ${HOME}/.local/share/icons/candy-icons
fi

# TODO - write to settings.ini
