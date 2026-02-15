# Memory architecture (OpenClaw / macclaw)

Goal: **not lose context**, **easy to find**, **rollbackable**, and **reduce chat context/token usage**.

## Principles

1) **Chat is not storage**: keep chat to short summaries + pointers (note title/path).
2) **No secrets in git**: tokens/API keys/login exports never go into this repo.
3) **Big files go to external drive** ("Big Data" drive) **with a local index**.
4) **Every decision becomes a record**: either an ADR (decision) or a PROGRESS entry (project).
5) **Session governance**: prefer starting a new chat/session once a topic phase is complete; use context compaction only as a temporary bridge.

---

## Layers

### L0 — Session (short-term)
- What: temporary working context while we are chatting.
- Persistence: none. If it matters, promote it to L1/L2/L3.

### L1 — Daily log (what happened today)
- Where: `memory/YYYY-MM-DD.md` (currently symlinked to external drive).
- What: short bullets: what changed, what we decided, next steps.

### L2 — Ops knowledge base (runbooks + scripts)
- Where: this git repo (`runbooks/`, `scripts/`).
- What: step-by-step recovery guides, safe workflows, checklists.

### L3 — Decisions / long-term memory (ADR)
- Where (recommended): Apple Notes (human-searchable) + *sanitized* ADR summaries in git.
- What: key decisions + rationale, environment facts, conventions.

### L4 — Big objects (data / DB / large assets)
- Where: external "Big Data" drive.
- What: datasets, databases, large project assets, archives.
- Rule: **must be indexed** in `bigdata/INDEX.csv`.

---

## Indexing the external drive (mandatory)

### Standard locations (confirmed)

- **Volume name**: `OpenClawData`
- **Big objects root**: `/Volumes/OpenClawData/bigdata/`
- **OpenClaw memory root**: `/Volumes/OpenClawData/openclaw/workspace/memory/`

### Files
- `bigdata/INDEX.csv` (source of truth for the index)
- `bigdata/INDEX.md` (optional human-friendly view)

### Minimum CSV fields
- name
- type (dataset|db|assets|backup)
- volume
- path
- project
- owner
- notes
- created_at
- updated_at

### SOP (every time you add big data)
1) Copy/move data to the external drive.
2) Add/update a row in `bigdata/INDEX.csv`.
3) If it impacts a project, add a line to `projects/<slug>/PROGRESS.md`.

---

## Session governance (trigger + actions)

### When to start a new chat/session (preferred)
Start a new chat/session when:
- the topic changes (project A -> project B), or
- we reached a phase boundary (decision made, config applied, a runbook written), or
- the UI shows repeated `Compacting context...`, or
- we notice early-message details are getting fuzzy.

### When to compact context and continue (temporary)
Compact and continue when:
- we are mid-procedure and cannot safely stop yet (ongoing debug / step-by-step verification), and
- we still need immediate access to the last few turns.

### Mandatory pre-switch check + 60-second checkpoint (before switching sessions)
Before switching sessions (starting a new chat/session), do both:

**Pre-switch check (verify persistence):**
- Confirm the important items have been written to the right layer (git runbook/project/index and/or Notes).
- If anything is only "in chat", write it down first.

**60-second checkpoint (capture):**
- decisions made (1–3 bullets)
- next step (1 bullet)
- pointers (paths, commands, external drive locations)

Promote to the right layer:
- ops/how-to -> `runbooks/`
- project progress -> `projects/<slug>/PROGRESS.md`
- big objects -> `bigdata/INDEX.csv`
- decisions -> Notes + (optional) sanitized ADR in git

---

## Project memory

For each project: `projects/<slug>/{SPEC,PROGRESS,HANDOFF}.md`.

---

## Apple Notes structure (recommended)

Folders:
- Ops
- Decisions (ADR)
- Projects

Each important change ends with a short note:
- 3–8 bullets summary
- pointers to git paths and external drive paths

---

## Memory hygiene / cleanup

Problem: daily logs and rules can accumulate; obsolete notes can confuse future work.

### What we clean
- L1 daily logs: remove/ignore noise; keep only what helps resume work.
- L3 rules/decisions: if a new rule supersedes an old one, mark the old one as **superseded** and link to the replacement.
- Index entries: keep (never delete) but mark entries as archived/deleted with notes.

### Cadence
- **Weekly (or after major changes):** 10–20 min review.
- **Monthly:** prune/merge long-running topics into a single ADR/runbook.

### Method
1) Identify what changed (new rule / new preferred path / new workflow).
2) Update the authoritative doc (runbook/ADR).
3) Add a short note in daily log referencing the authoritative update.
4) Tag old material as `SUPERSEDED:` with a pointer to the new source.

### Never do automatically
- Deleting raw history without an explicit user request.
