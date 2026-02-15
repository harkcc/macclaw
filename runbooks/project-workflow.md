# Project workflow (rollbackable, minimum viable certainty)

This is the default workflow for any "project" work.

## Principles

1) **Rollbackable by default**
   - Use git branches + small commits.
   - Prefer reversible operations; back up before risky changes.

2) **Minimum viable certainty**
   - Start with the smallest executable slice that can be verified.
   - Avoid premature optimization / full-scope builds.

3) **Minimal trace, maximal clarity**
   - Leave the smallest set of artifacts that lets a future you (or another agent) continue safely:
     - a short spec
     - a progress log
     - a handoff/context doc
     - commits

4) **No fake resources**
   - If required resources/data/credentials are missing, stop and ask.
   - If we must proceed, label assumptions explicitly.

5) **Stage & validate**
   - Thin end-to-end “happy path” first.
   - Then expand features, coverage, and automation.

## Standard artifacts (per project)

Create a folder under `projects/<project-slug>/`:

- `SPEC.md` — product-style spec
- `PROGRESS.md` — running log of what changed and what remains
- `HANDOFF.md` — context for other agents / future sessions

## SPEC.md template (required fields)

- Problem / opportunity
- Target user + scenario
- **Final output** (what exists when done)
- **Success metrics** (quantified)
- Constraints (time, budget, platforms, data sources)
- Resources provided (accounts, APIs, datasets, links)
- Risks / unknowns
- Minimal viable slice (first milestone)
- Verification plan (how we test/measure)

## PROGRESS.md rules

- Each entry: date/time, what changed, links to commits/PRs, next steps.
- Keep it short and operational.

## HANDOFF.md rules

- Current state in 10 bullets
- Decisions made + rationale
- How to run/test
- Where secrets live (never in repo)
- Open questions

## When to ask you questions

I must ask (not assume) when:

- success criteria are ambiguous
- data sources are unclear or not provided
- a decision is irreversible or high-impact
- the project scope is drifting

