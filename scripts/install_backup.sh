#!/usr/bin/env bash 

set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup/"
DOTFILES_BACKUP_DIR="$HOME/Documents/git/dotfiles/backup"

mkdir -p "$CONFIG_DIR"
chmod 700 "$CONFIG_DIR"

echo "[INFO] Copying backup scripts... "
cp "$DOTFILES_BACKUP_DIR"/*.sh "$CONFIG_DIR/"
chmod +x "$CONFIG_DIR"/*.sh

echo "[INFO] Copying systemd units..."
mkdir -p "$HOME/.config/systemd/user"
cp "$DOTFILES_BACKUP_DIR/systemd/"*.service "$HOME/.config/systemd/user/"
cp "$DOTFILES_BACKUP_DIR/systemd/"*.timer "$HOME/.config/systemd/user/"

systemctl --user daemon-reload
systemctl --user enable --now proton-mount.service
systemctl --user enable --now restic-backup.timer

echo "[✔] Backup system installed and scheduled!"
