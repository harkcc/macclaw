#!/usr/bin/env bash
set -euo pipefail

BACKUP_PATH="${1:-}"
CONFIG_PATH="${OPENCLAW_CONFIG_PATH:-$HOME/.openclaw/openclaw.json}"

if [[ -z "$BACKUP_PATH" ]]; then
  echo "Usage: $0 <backup-config-path>" >&2
  exit 2
fi
if [[ ! -f "$BACKUP_PATH" ]]; then
  echo "Backup not found: $BACKUP_PATH" >&2
  exit 1
fi

cp "$BACKUP_PATH" "$CONFIG_PATH"
chmod 600 "$CONFIG_PATH" || true

echo "Rolled back OpenClaw config:"
echo "  from: $BACKUP_PATH"
echo "  to:   $CONFIG_PATH"

echo "Restarting gateway..."
openclaw gateway restart

echo "Done. Verify with: openclaw status"
