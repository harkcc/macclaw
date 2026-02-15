# Safe model addition (no meltdowns)

Goal: add new model providers/profiles **without** breaking the current stable setup.

## Non-negotiables

- Do **not** change the default model during initial setup.
- Make changes as **small patches**.
- Keep Desktop app from rewriting config (treat it as a client only).
- Always have a rollback path ready.

## 0) Preflight

```bash
openclaw gateway status
openclaw status
```

Ensure there is only one gateway process (LaunchAgent).

## 1) Backup (required)

```bash
bash scripts/openclaw-config-backup.sh
```

Copy the printed backup path somewhere safe.

## 2) Enable the provider plugin (if needed)

Example:

```bash
openclaw plugins enable google-gemini-cli-auth
# or: openclaw plugins enable google-antigravity-auth
openclaw gateway restart
```

## 3) Run provider auth flow (OAuth/API key)

```bash
openclaw models auth login
```

Choose provider + method. This should create/update `auth-profiles.json` and config references.

## 4) Validate without touching defaults

- Check model status:

```bash
openclaw models status --plain
```

- Run a small, isolated test task using the new model/profile (do not switch default yet).

## 5) Only after success: optional promotion

- Add to fallbacks, or set as default:

```bash
openclaw models fallbacks ...
openclaw models set ...
```

## Rollback (one command)

```bash
bash scripts/openclaw-config-rollback.sh <path-to-backup>
```

If the issue is OAuth credentials only, you may also remove/disable the new auth profile rather than rolling back the entire config.

