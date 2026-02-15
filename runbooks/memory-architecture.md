# Memory architecture (OpenClaw / macclaw)

Goal: **not lose context**, **easy to find**, **rollbackable**, and **reduce chat context/token usage**.

## Principles

1) **Chat is not storage**: keep chat to short summaries + pointers (note title/path).
2) **No secrets in git**: tokens/API keys/login exports never go into this repo.
3) **Big files go to external drive** ("Big Data" drive) **with a local index**.
4) **Every decision becomes a record**: either an ADR (decision) or a PROGRESS entry (project).

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
