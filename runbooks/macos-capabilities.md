# macOS capabilities to leverage (Notes/Reminders/Messages/Browser)

Goal: use macOS-native capabilities as an externalized knowledge base + task system, reducing chat context loss.

## Principles
- Prefer **writing to local systems** (Notes/Reminders/git) over keeping details in chat.
- Use the layered memory system: daily log -> runbooks/projects -> Notes/ADR -> bigdata index.
- Be careful with sensitive data: no secrets in git.

## Capabilities

### Apple Notes (knowledge base)
Use for:
- decision records (ADR summaries)
- project context summaries
- how-to notes and quick references
- meeting/brainstorm notes

Rule:
- Each significant decision ends with a short note (3–8 bullets) + pointers to git paths and bigdata paths.

### Apple Reminders (action tracking)
Use for:
- important reminders
- due dates, follow-ups
- recurring checklists

Rule:
- Project tasks should link back to project `projects/<slug>/PROGRESS.md`.

### Messages (iMessage/SMS)
Use for:
- sending you confirmations/alerts when needed
- (optional) proactive notifications when a workflow completes

Safety:
- always ask before sending
- for test sends, confirm recipient + text

### Browser automation
Use for:
- web research, form filling, screenshots/snapshots

Two paths:
- Chrome + OpenClaw Browser Relay: best when logged-in access is required
- OpenClaw isolated browser: best for public browsing and safer automation

## Minimal verification commands (macOS)
- Reminders: `remindctl status` / `remindctl list`
- Notes: `memo notes` / `memo notes -s "query"`
- Messages (read): `imsg chats --limit 5 --json`
