#!/usr/bin/env bash
set -euo pipefail

CONFIG_PATH="${OPENCLAW_CONFIG_PATH:-$HOME/.openclaw/openclaw.json}"
TS="$(date +%Y%m%d-%H%M%S)"
OUT="${1:-$HOME/.openclaw/openclaw.json.bak.$TS}"

if [[ ! -f "$CONFIG_PATH" ]]; then
  echo "Config not found: $CONFIG_PATH" >&2
  exit 1
fi

cp "$CONFIG_PATH" "$OUT"
chmod 600 "$OUT" || true

echo "Backed up OpenClaw config:"
echo "  from: $CONFIG_PATH"
echo "  to:   $OUT"
