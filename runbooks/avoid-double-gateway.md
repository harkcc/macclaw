# Avoid Double Gateway (macOS)

Goal: ensure there is **exactly one** OpenClaw gateway running, to prevent config drift, token mismatch, and “dashboard/CLI pointing at different gateways”.

## Recommended architecture (single source of truth)

- **Gateway**: run via **LaunchAgent** (`ai.openclaw.gateway.plist`)
- **Clients**: Control UI (browser), CLI (`openclaw ...`), Chrome Browser Relay, etc.
- **Do not** run OpenClaw Desktop in a mode that starts its own gateway or rewrites `~/.openclaw/openclaw.json`.

## Check what is running

```bash
openclaw gateway status
openclaw status
ps aux | egrep -i 'openclaw|gateway' | egrep -v egrep
launchctl list | egrep -i 'openclaw|claw'
```

Expected: one `openclaw-gateway` process, one LaunchAgent entry.

## If you suspect a second gateway

1) Identify listeners (port conflicts)

```bash
lsof -nP -iTCP -sTCP:LISTEN | egrep '18789|openclaw|node'
```

2) Keep the LaunchAgent gateway, stop the other instance (do **not** kill blindly; prefer service commands)

```bash
openclaw gateway restart
```

3) Ensure Desktop App does NOT auto-start a gateway

- Prefer using the browser dashboard: `http://127.0.0.1:18789/`
- If Desktop is installed, disable any:
  - “Start gateway automatically”
  - “Switch to remote mode automatically”
  - config auto-write features

## Guardrails

- Never commit `~/.openclaw/openclaw.json` to git (contains tokens)
- Treat Desktop App as a *client* only (if used)

