#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup"
PASSWORD_FILE="$CONFIG_DIR/restic-password.gpg"
RCLONE_CONF="$CONFIG_DIR/rclone.conf"
RCLONE_CONF_GPG="$RCLONE_CONF.gpg"
REMOTE_NAME_FILE="$CONFIG_DIR/remote-name.txt"

mkdir -p "$CONFIG_DIR"
chmod 700 "$CONFIG_DIR"

read -rp "Enter the rclone remote name (e.g. 's3-restic-backup'): " RCLONE_NAME
echo "$RCLONE_NAME" > "$REMOTE_NAME_FILE"

echo "[INFO] Launching rclone config... for remote: $RCLONE_NAME"
if [[ -f "$CONFIG_DIR/rclone.conf.gpg" ]]; then
    TMP_RCLONE_CONF=$(mktemp /run/user/$(id -u)/rclone.conf.XXXXXX)
    gpg --quiet --decrypt "$RCLONE_CONF_GPG" > "$TMP_RCLONE_CONF"
    chmod 600 "$TMP_RCLONE_CONF"
    trap 'rm -f "$TMP_RCLONE_CONF"' EXIT
    rclone config --config "$TMP_RCLONE_CONF"
else
    rclone config --config "$CONFIG_DIR/rclone.conf"
    RCLONE_CONF="$CONFIG_DIR/rclone.conf"
    RCLONE_CONF_GPG="$CONFIG_DIR/rclone.conf.gpg"
    
    echo "[INFO] Encrypting rclone.conf..."
    gpg --symmetric --cipher-algo AES256 -o "$RCLONE_CONF_GPG" "$RCLONE_CONF"
    chmod 600 "$RCLONE_CONF_GPG"
    shred -u "$RCLONE_CONF"
fi


echo "[INFO] Enter your Restic repository password:"
read -rs RESTIC_PW
echo "$RESTIC_PW" | gpg --symmetric --cipher-algo AES256 -o "$PASSWORD_FILE"
chmod 600 "$PASSWORD_FILE"

echo "Setting up email authentication. If on gmail, create an app "
echo "password by going to https://myaccount.google.com/apppasswords"
echo "and paste that in the next prompt"

read -rp "Enter your Gmail address for backup notifications: " BACKUP_EMAIL
echo "$BACKUP_EMAIL" > "$CONFIG_DIR/email.txt"
chmod 600 "$CONFIG_DIR/email.txt"

echo "[INFO] Enter your Gmail app password (16 characters):"
read -rs GMAIL_APP_PW
GMAIL_APP_PW_STRIPPED=$(echo "$GMAIL_APP_PW" | tr -d ' ')
echo "$GMAIL_APP_PW_STRIPPED" | gpg --symmetric --cipher-algo AES256 -o "$CONFIG_DIR/mail-password.gpg"

# Decrypt secrets to init the repo
echo "[INFO] Decrypting for repo init..."
TMP_RCLONE_CONF=$(mktemp /run/user/$(id -u)/rclone.conf.XXXXXX)
gpg --quiet --decrypt "$RCLONE_CONF_GPG" > "$TMP_RCLONE_CONF"
chmod 600 "$TMP_RCLONE_CONF"

RESTIC_PASSWORD=$(gpg --quiet --decrypt "$PASSWORD_FILE")
RESTIC_REPOSITORY="rclone:${RCLONE_NAME}:${RCLONE_NAME}"

RCLONE_CONFIG="$TMP_RCLONE_CONF" RESTIC_PASSWORD="$RESTIC_PASSWORD" RESTIC_REPOSITORY="$RESTIC_REPOSITORY" \
    restic init || echo "[WARN] Repo may already be initialized."

rm -f "$TMP_RCLONE_CONF"

echo "[✔] Setup complete for $RCLONE_NAME"
