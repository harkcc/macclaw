# Fix `device_token_mismatch` (OpenClaw)

Symptom (logs / CLI):

- `unauthorized: device token mismatch (rotate/reissue device token)`
- Control UI/CLI keeps disconnecting with code 1008

Root cause:

A client (often a different UI instance / Desktop app / another machine) is trying to connect using a **different device token** than the gateway expects. This can happen after config rewrites, switching local/remote modes, restoring backups, or pairing changes.

## 0) Make sure only one gateway is running

Follow: `runbooks/avoid-double-gateway.md`.

## 1) Confirm the gateway is reachable locally

```bash
openclaw gateway status
```

You should see something like `Listening: 127.0.0.1:18789`.

## 2) Re-pair / re-authorize the client

Do the least invasive option first:

### Option A: refresh the UI / client

- Close dashboard tab(s)
- Re-open `http://127.0.0.1:18789/`

### Option B: rotate/re-issue the device token (when a specific client is stuck)

Use the dashboard (preferred) to re-pair/approve the device again.

If you used a Desktop app before, ensure it is not running another gateway and not rewriting config.

## 3) If the CLI is the one failing

Try:

```bash
openclaw status
```

If it still reports mismatch, restart gateway:

```bash
openclaw gateway restart
```

Then retry.

## 4) Last resort (careful)

If config has been overwritten repeatedly and you want a clean state:

- Back up `~/.openclaw/openclaw.json`
- Re-run onboarding/doctor and re-pair devices

Do this only if Options A–C fail.

## Prevention

- Keep a single gateway (LaunchAgent)
- Avoid Desktop auto-config writes / local↔remote flips
- Track changes in your ops repo (this repository)

