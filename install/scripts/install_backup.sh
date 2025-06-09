#!/usr/bin/env bash 

set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup/"
DOTFILES_BACKUP_DIR="$HOME/Documents/git/dotfiles/backup"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"

mkdir -p "$CONFIG_DIR" "$SYSTEMD_USER_DIR" "$HOME/.local/share/rclone"
chmod 700 "$CONFIG_DIR"

echo "[INFO] Copying backup scripts... "
cp "$DOTFILES_BACKUP_DIR"/*.sh "$CONFIG_DIR/"
chmod +x "$CONFIG_DIR"/*.sh

mkdir -p "$HOME/.local/share/rclone"

echo "[INFO] Copying systemd units..."
cp "$DOTFILES_BACKUP_DIR/systemd/"*.service "$SYSTEMD_USER_DIR/"
cp "$DOTFILES_BACKUP_DIR/systemd/"*.timer "$SYSTEMD_USER_DIR/"

echo "[INFO] Setting up restic repo and encrypting secrets..."
bash "$DOTFILES_BACKUP_DIR/restic-setup.sh"

systemctl --user daemon-reload
systemctl --user enable --now restic-backup.timer

echo "[✔] Backup system installed and scheduled!"

read -p "Would you like to run an initial backup now? (y/n): " INIT_RUN
if [[ $INIT_RUN =~ ^[Yy]$ ]]; then
    systemctl --user start restic-backup.service
    echo "Waiting a few seconds to check if service starts..."
    sleep 10
    systemctl status --user restic-backup.service
fi
