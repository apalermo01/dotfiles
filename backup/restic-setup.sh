#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup"
PASSWORD_FILE="$CONFIG_DIR/restic-password.gpg"
REMOTE_NAME_FILE="$CONFIG_DIR/remote-name.txt"

mkdir -p "$CONFIG_DIR"
chmod 700 "$CONFIG_DIR"

read -rp "Enter the rclone remote name (e.g. 'proton-restic-backup'): " RCLONE_NAME
echo "$RCLONE_NAME" > "$REMOTE_NAME_FILE"

# --- Step 1: Rclone setup ---
echo "[INFO] Launching rclone config... for remote: $RCLONE_NAME"
rclone config --config "$CONFIG_DIR/rclone.conf"

# --- Step 2: Prompt for password and encrypt it ---
echo "[INFO] Enter your Restic repository password:"
read -rs RESTIC_PW

echo "[INFO] Encrypting password using GPG..."
echo "$RESTIC_PW" | gpg --symmetric --cipher-algo AES256 -o "$PASSWORD_FILE"

chmod 600 "$PASSWORD_FILE"

# --- Step 3: Initialize the restic repo ---
echo "[INFO] Decrypting password and initializing repo..."
RESTIC_PASSWORD=$(gpg --quiet --decrypt "$PASSWORD_FILE")
export RESTIC_PASSWORD
RESTIC_REPOSITORY="rclone:${RCLONE_NAME}:${RCLONE_NAME}"
export RESTIC_REPOSITORY

export RCLONE_CONFIG="$CONFIG_DIR/rclone.conf"
restic init || echo "[WARN] Repo may already be initialized."

echo "[✔] Setup complete for $RCLONE_NAME. You can now run backups via systemd or manually."
