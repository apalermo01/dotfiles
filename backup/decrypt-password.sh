#!/usr/bin/env bash
set -euo pipefail
CONFIG_DIR="$HOME/.config/restic-setup"
REMOTE_NAME=$(<"$CONFIG_DIR/remote-name.txt")

PASSWORD_FILE="$CONFIG_DIR/restic-password.gpg"
RCLONE_CONF_GPG="$CONFIG_DIR/rclone.conf.gpg"

# Decrypt Restic password
export RESTIC_PASSWORD=$(gpg --quiet --decrypt "$PASSWORD_FILE")

# Decrypt rclone.conf to a temp file
TMP_RCLONE_CONF=$(mktemp)
gpg --quiet --decrypt "$RCLONE_CONF_GPG" > "$TMP_RCLONE_CONF"
chmod 600 "$TMP_RCLONE_CONF"
export RCLONE_CONFIG="$TMP_RCLONE_CONF"

export RESTIC_REPOSITORY="rclone:${REMOTE_NAME}:${REMOTE_NAME}"

# Call wrapped command and clean up afterward
trap 'rm -f "$TMP_RCLONE_CONF"' EXIT
exec "$@"
