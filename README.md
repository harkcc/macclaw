# macclaw

OpenClaw on macOS: ops playbook + change log + safe (de‑sensitized) config templates.

## What goes in this repo

- `runbooks/` — step-by-step guides (avoid double gateway, token mismatch recovery, etc.)
- `scripts/` — helper scripts (mount data volume, backups, log collection)
- `openclaw/` — **sanitized** config templates (no tokens / API keys)
- `changelog/` — short human-readable change notes

## What must NOT go in this repo

- `~/.openclaw/openclaw.json` (contains tokens / API keys)
- any `credentials/` exports or backups
- chat logs or personal memory files

## Quick start

- Dashboard: http://127.0.0.1:18789/
- Gateway service status: `openclaw gateway status`
