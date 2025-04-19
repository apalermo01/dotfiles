#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup"
RCLONE_NAME="proton"
RESTIC_REMOTE="${RCLONE_NAME}:proton-restic-backup"
PASSWORD_FILE="$CONFIG_DIR/restic-password.gpg"

mkdir -p "$CONFIG_DIR"
chmod 700 "$CONFIG_DIR"

# --- Step 1: Rclone setup ---
echo "[INFO] Launching rclone config..."
echo "[IMPORTANT] you MUST call the remote repo 'proton-restic-backup'"
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
RESTIC_REPOSITORY="rclone:${RESTIC_REMOTE}"
export RESTIC_REPOSITORY

restic init || echo "[WARN] Repo may already be initialized."

echo "[✔] Setup complete. You can now run backups via systemd or manually."
