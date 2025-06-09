#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/restic-setup"
REMOTE_NAME=$(cat "$CONFIG_DIR/remote-name.txt")
REPO="rclone:${REMOTE_NAME}:${REMOTE_NAME}"

# Source the decrypt script to export environment variables
source "$CONFIG_DIR/decrypt-password.sh"

# List snapshots
echo "📋 Available snapshots:"
restic -r "$REPO" snapshots --compact
echo

# Prompt for snapshot ID
read -p "Enter the snapshot ID to restore: " SNAPSHOT_ID

# Confirm restore target
RESTORE_TARGET="$HOME"
echo "🗂  Files will be restored to: $RESTORE_TARGET"
read -p "Are you sure you want to continue? (y/n): " CONFIRM
[[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]] && echo "❌ Restore cancelled." && exit 0

# Perform the restore
echo "⏳ Starting restore..."
restic -r "$REPO" restore "$SNAPSHOT_ID" \
  --target "$RESTORE_TARGET" \
  --exclude "$HOME/Documents/git/dotfiles"

echo "✅ Restore completed successfully."

