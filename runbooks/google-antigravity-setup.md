# Google antigravity (OAuth) setup + safe usage

## Goal
Enable Google antigravity provider via OAuth, keep **codex as global default**, and allow using `google-antigravity/gemini-3-pro-high` for selected tasks/subagents.

## Safety rules (do not break stable setup)
- Do **not** change global default model during onboarding.
- Always keep a rollback path (config backup) before risky edits.
- Never commit `~/.openclaw/openclaw.json` to git (contains tokens).

## Steps

### 1) Enable plugin
```bash
openclaw plugins enable google-antigravity-auth
openclaw gateway restart
```

### 2) OAuth login
```bash
openclaw models auth login
```
Expected log includes `Antigravity OAuth complete`.

### 3) Verify provider models are visible
```bash
openclaw models list --provider google-antigravity --plain
```

### 4) Keep codex as default
Verify:
```bash
openclaw models status --plain
```
Expected: `openai-codex/gpt-5.3-codex`

### 5) Allow additional Google model(s) for this agent (so subagent can use it)
Symptom: trying to run a subagent with `google-antigravity/gemini-3-pro-high` yields `model not allowed`.

Fix: add it to the agent-allowed model list in `~/.openclaw/openclaw.json` under:
- `agents.defaults.models`

Example (incremental add; do not touch `agents.defaults.model.primary`):
```json
{
  "agents": {
    "defaults": {
      "models": {
        "google-antigravity/claude-opus-4-6-thinking": {},
        "google-antigravity/gemini-3-pro-high": {}
      }
    }
  }
}
```
Then:
```bash
openclaw gateway restart
openclaw models status --json
```
Confirm `allowed` includes `google-antigravity/gemini-3-pro-high` and `defaultModel` stays codex.

## Notes
- The CLI message `Default model available: google-antigravity/claude-opus-4-6-thinking (use --set-default to apply)` is only a suggestion; it does **not** switch your global default unless you explicitly set it.
- Model "low/medium/high/thinking" may be represented as **different model IDs** (provider-specific), not a universal knob.
