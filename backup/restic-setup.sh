#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup"
PASSWORD_FILE="$CONFIG_DIR/restic-password.gpg"
REMOTE_NAME_FILE="$CONFIG_DIR/remote-name.txt"

mkdir -p "$CONFIG_DIR"
chmod 700 "$CONFIG_DIR"

read -rp "Enter the rclone remote name (e.g. 's3-restic-backup'): " RCLONE_NAME
echo "$RCLONE_NAME" > "$REMOTE_NAME_FILE"

# --- Step 1: Rclone setup ---
echo "[INFO] Launching rclone config... for remote: $RCLONE_NAME"
rclone config --config "$CONFIG_DIR/rclone.conf"

RCLONE_CONF="$CONFIG_DIR/rclone.conf"
RCLONE_CONF_GPG="$CONFIG_DIR/rclone.conf.gpg"

# --- Encrypt rclone.conf and remove plaintext ---
echo "[INFO] Encrypting rclone.conf..."
gpg --symmetric --cipher-algo AES256 -o "$RCLONE_CONF_GPG" "$RCLONE_CONF"
chmod 600 "$RCLONE_CONF_GPG"
shred -u "$RCLONE_CONF"

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

# Decrypt rclone.conf temporarily for restic init
TMP_RCLONE_CONF=$(mktemp)
gpg --quiet --decrypt "$RCLONE_CONF_GPG" > "$TMP_RCLONE_CONF"
chmod 600 "$TMP_RCLONE_CONF"

export RESTIC_REPOSITORY="rclone:${RCLONE_NAME}:${RCLONE_NAME}"
export RCLONE_CONFIG="$TMP_RCLONE_CONF"
restic init || echo "[WARN] Repo may already be initialized."

echo "[✔] Setup complete for $RCLONE_NAME. You can now run backups via systemd or manually."
