#!usr/bin/env sh

# installing theme builder
echo "Installing theme builder..."
bash ./scripts/install_theme_builder.sh

echo "Building themes..."
nix-shell --command "cd theme-builder && bash migrate_theme_to_dotfiles.sh all"
