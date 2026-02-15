# HANDOFF — Google antigravity + multi-agent (A卷)

## Current state (summary)
- Stable default remains: `openai-codex/gpt-5.3-codex`.
- Google antigravity OAuth completed.
- Google model allowed for tasks/subagents: `google-antigravity/gemini-3-pro-high`.

## Key decisions
- Do not switch global default when onboarding new providers/models.
- Use allowlist/agent model list to enable specific models for subagents.

## How to verify
- `openclaw models status --plain` should show codex.
- `openclaw models status --json` should include `google-antigravity/gemini-3-pro-high` in `allowed`.

## Risks
- Editing `~/.openclaw/openclaw.json` is risky; always backup first.
- Never commit that config file to git.
