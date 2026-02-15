# SPEC — Google antigravity + multi-agent (A卷) setup

## Problem / opportunity
We want multiple agents (A卷) that can cooperate quickly, while keeping a stable default model and avoiding configuration meltdowns.

## Target scenario
- Main agent stays on `openai-codex/gpt-5.3-codex`.
- A Google-focused agent/subagent can use `google-antigravity/gemini-3-pro-high`.
- Web research can be done via OpenClaw browser automation and/or Chrome Browser Relay when authorized.

## Final output
- A documented, rollbackable process to enable Google antigravity OAuth.
- A documented process to allow `google-antigravity/gemini-3-pro-high` without changing global defaults.
- A lightweight multi-agent coordination pattern (dispatch + report + docs).

## Success metrics
- Can run one test subagent using `google-antigravity/gemini-3-pro-high` successfully.
- `openclaw models status --plain` remains `openai-codex/gpt-5.3-codex`.
- Recovery: can revert config to last-known-good in < 2 minutes.

## Constraints
- No secrets in git.
- Changes must be reversible (backup + small patch).

## Minimal viable slice (first milestone)
1) Google antigravity OAuth works.
2) `gemini-3-pro-high` is in allowed list.
3) Run one tiny subagent task with it.

## Verification plan
- Record the exact CLI outputs (status + allowed list) in PROGRESS.
- Run a small task and confirm response is produced.
