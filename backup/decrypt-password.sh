#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup"
PASSWORD_FILE="$CONFIG_DIR/restic-password.gpg"
RCLONE_CONF_GPG="$CONFIG_DIR/rclone.conf.gpg"
REMOTE_NAME=$(cat "$CONFIG_DIR/remote-name.txt")

# Decrypt secrets to temp files in /run
TMP_RCLONE_CONF=$(mktemp /run/user/$(id -u)/rclone.conf.XXXXXX)
gpg --quiet --decrypt "$RCLONE_CONF_GPG" > "$TMP_RCLONE_CONF"
chmod 600 "$TMP_RCLONE_CONF"

RESTIC_PASSWORD=$(gpg --quiet --decrypt "$PASSWORD_FILE")
export RESTIC_PASSWORD
export RCLONE_CONFIG="$TMP_RCLONE_CONF"
export RESTIC_REPOSITORY="rclone:${REMOTE_NAME}:${REMOTE_NAME}"

# --- Gmail mail.rc generation ---
MAILRC_TMP=$(mktemp /run/user/$(id -u)/mail.rc.XXXXXX)
MAIL_PASS=$(gpg --quiet --decrypt "$CONFIG_DIR/mail-password.gpg")
GMAIL_USER=$(cat "$CONFIG_DIR/email.txt")

cat <<EOF > "$MAILRC_TMP"
set smtp=smtp://smtp.gmail.com:587
set smtp-auth=login
set smtp-auth-user=$GMAIL_USER
set smtp-auth-password=$MAIL_PASS
set from="$GMAIL_USER"
EOF

chmod 600 "$MAILRC_TMP"
export MAILRC="$MAILRC_TMP"





# Clean up temp file on exit
trap 'rm -f "$TMP_RCLONE_CONF" "$MAILRC_TMP"' EXIT

if [[ $# -gt 0 ]]; then
    exec "$@"
# else
#     exec "$CONFIG_DIR/backup.sh"
fi
