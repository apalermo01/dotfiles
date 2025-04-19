#!/bin/bash

echo "=========================================="
echo "==== Running install and switch theme ===="
echo "=========================================="

if [ ! -d ./theme-builder/themes ]; then 
    echo "theme $1 does not exist!"
    exit
fi

cd ./theme-builder
bash migrate_theme_to_dotfiles.sh $1
echo "======================================================"
echo "==== Theme successfully migrated to dotfiles repo ===="
echo "======= Now running switch theme script =============="
echo "======================================================"
cd ..

bash switch_theme.sh $1
