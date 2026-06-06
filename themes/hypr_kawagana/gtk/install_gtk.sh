# theme
THEME_DIR=${HOME}/.cache/GTK-Kanagawa

if [[ ! -d ${THEME_DIR} ]]; then
    mkdir -p ${THEME_DIR}
    curl -sL https://github.com/Fausto-Korpsvart/Kanagawa-GKT-Theme/archive/refs/heads/main.zip -o ${THEME_DIR}/kanagawa-gtk.zip

    unzip ${THEME_DIR}/kanagawa-gtk.zip -d ${THEME_DIR}/kanagawa-gtk
    rm ${THEME_DIR}/kanagawa-gtk.zip

fi

# theme: default, green, gray, orange, pink, purple, red, teal, yellow, all
# color: light, dark
# size: standard, compact
# tweaks: dragon, black, outline, float, macos
theme="Yellow"
color="Dark"
tweaks="Dragon Outline Float"
bash ${THEME_DIR}/kanagawa-gtk/Kanagawa-GKT-Theme-main/themes/install.sh \
    --theme "${theme,,}" \
    --color "${color,,}" \
    --size standard \
    --tweaks "${tweaks,,}"


