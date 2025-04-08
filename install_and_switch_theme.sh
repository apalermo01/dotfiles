#!/bin/bash

if [ ! -d ./theme-builder/themes ]; then 
    echo "theme $1 does not exist!"
    exit
fi

cd ./theme-builder

bash migrate_theme_to_dotfiles.sh $1
echo "Theme successfully migrated to dotfiles repo"
cd ..

bash switch_theme.sh $1
