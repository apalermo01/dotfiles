
# theme
THEME_DIR=${HOME}/.cache/GTK-catppuccin

if [[ ! -d $THEME_DIR ]]; then
    mkdir -p $THEME_DIR
    curl -sL https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme/archive/refs/heads/main.zip -o ${THEME_DIR}/catppuccin-gtk.zip

    unzip ${THEME_DIR}/catppuccin-gtk.zip -d ${THEME_DIR}/catppuccin-gtk
    rm ${THEME_DIR}/catppuccin-gtk.zip
fi

bash ${THEME_DIR}/catppuccin-gtk/Catppuccin-GTK-Theme-main/themes/install.sh

# icons
# ICON_DIR=${HOME}/.cache/GTK-sweet-icons 
# if [[ ! -d $ICON_DIR ]]; then
#     mkdir -p $ICON_DIR
#     curl -sL https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip -o ${ICON_DIR}/candy-icons.zip
#
#     unzip ${ICON_DIR}/candy-icons.zip -d ${ICON_DIR}/candy-icons
#     rm ${ICON_DIR}/candy-icons.zip
#
#     mv ${ICON_DIR}/candy-icons/candy-icons-master ${HOME}/.local/share/icons/candy-icons
# fi
#
# # TODO - write to settings.ini
