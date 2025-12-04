#!/usr/bin/env bash
set -euo pipefail

echo "====================================="
echo "==== Running switch theme script ===="
echo "====================================="

DOTPATH="$HOME/Documents/git/dotfiles"
RICER_DIR="$HOME/.config/ricer"

cd "$DOTPATH"

if [ ! -d "./built_themes/$1" ]; then
    echo "theme $1 does not exist"
    exit 1
fi

# Ensure ricer config dir exists before linking
mkdir -p "$RICER_DIR"

# On first run (no current_theme), proactively back up common conflicting files
for f in "$HOME/.zshrc" "$HOME/.profile" "$HOME/.bashrc" "$HOME/.zshenv" "$HOME/.tmux.conf"; do
if [ -f "$f" ] && [ ! -L "$f" ]; then
  mv -f "$f" "${f}.pre-dotfiles.bak"
  echo "Backed up $f -> ${f}.pre-dotfiles.bak"
fi
done

if [ -f "./current_theme" ]; then
    current_theme="$(cat ./current_theme)"
    echo "un-stowing current theme: $current_theme"
    if ! stow --delete . -d "built_themes/$current_theme" -t "$HOME" --dotfiles; then
        echo "unstow failed, exiting"
        exit 1
    else
        echo "unstow successful!"
    fi
fi

echo "stowing new theme: $1"
stow . -d "built_themes/$1" -t "$HOME" --dotfiles --adopt --verbose=1

if [[ "$1" == *"wsl"* ]]; then
    ln -sf "$(realpath ./templates/global-wsl.yml)" "$RICER_DIR/ricer-global-before.yml"
    ln -sf "$(realpath ./templates/global-wsl-after.yml)" "$RICER_DIR/ricer-global-after.yml"
else
    ln -sf "$(realpath ./templates/global-before.yml)" "$RICER_DIR/ricer-global-before.yml"
    ln -sf "$(realpath ./templates/global-after.yml)" "$RICER_DIR/ricer-global-after.yml"
fi

echo "stow successful!"

echo "running theme install scripts"
if [ -d ./built_themes/$1/.config/theme_scripts/ ]; then
    # TODO: this section is no longer in use
    for fname in $(ls ./themes/$1/.config/theme_scripts/ | sort); do
        script="./themes/$1/.config/theme_scripts/$fname"
        if [ -x "$script" ]; then
            echo "Executing $script"
            "$script"
        else
            echo "Skipping $script: not executable"
        fi
    done
elif [ -f ./built_themes/$1/.config/install_theme.sh ]; then
    echo "Executing install script"
    bash "./built_themes/$1/.config/install_theme.sh"
else
    echo "no theme install scripts detected"
fi

echo $1 > current_theme

echo "copying user scripts"
if [ ! -d $HOME/Scripts ]; then 
    mkdir $HOME/Scripts/ 
fi
stow . -d user_scripts/ -t ~/Scripts

if command -v i3 >/dev/null 2>&1; then
    i3 restart
fi
chmod +x "$HOME/Documents/git/dotfiles/scripts/switch_theme.sh"
