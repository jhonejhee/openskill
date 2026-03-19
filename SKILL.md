---
name: openskill
description: Project-aware skill discovery and installer for Claude projects. Use this skill whenever the user runs /openskill (with or without a scope like "frontend", "backend", "debug", "code-review", "api", "data", "infra", "testing"). Trigger on any message that starts with /openskill or asks to "find skills for my project", "install skills", "discover skills", or "what skills should I add". This is a package-manager-style interactive workflow — always use it for any skill installation or discovery request, even if the user just says "/openskill" with no arguments.
---

# OpenSkill — Project-Aware Skill Discovery & Installer

A package-manager-style skill that reads your project, discovers relevant Claude skills from multiple sources, and installs them interactively.

---

## Commands

| Command | Behavior |
|---|---|
| `/openskill` | Full interactive project scan + skill discovery + install |
| `/openskill frontend` | Scope discovery to frontend/UI skills |
| `/openskill backend` | Scope discovery to backend/API/server skills |
| `/openskill debug` | Skills for debugging, error tracing, logging |
| `/openskill code-review` | Skills for code quality, review, linting |
| `/openskill api` | Skills for API design, REST, GraphQL, OpenAPI |
| `/openskill data` | Skills for data pipelines, spreadsheets, analytics |
| `/openskill infra` | Skills for DevOps, cloud, CI/CD, containers |
| `/openskill testing` | Skills for testing, QA, coverage, e2e |

---

## Workflow

### Step 1 — Read the Project

When `/openskill` is invoked:

1. **Check for `CLAUDE.md`** in the project root. Read it if present — it contains project context, stack, and existing skill references.
2. **Scan the codebase** if no CLAUDE.md exists or to supplement it:
   - Look at `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `composer.json`, etc. to detect stack and dependencies
   - Check for framework indicators: `next.config.*`, `vite.config.*`, `tailwind.config.*`, `Dockerfile`, `.github/workflows/`, etc.
   - Note the primary languages, frameworks, and tooling in use
3. **Detect the scope** from the command argument (e.g., `/openskill frontend` → focus on frontend-relevant skills). If no scope given, infer from the full project read.

Summarize what you found in 2–3 sentences before proceeding.

---

### Step 2 — Discover Skills

Search for relevant skills across **three tiers in order**:

#### Tier 1: Local Skills (check first)
Scan these paths for already-available skills:
- `/mnt/skills/user/` — user-installed skills
- `/mnt/skills/public/` — built-in public skills
- `/mnt/skills/examples/` — example skills

For each skill found, read only its **YAML frontmatter** (name + description). Do not load full SKILL.md bodies — just names and descriptions are enough for matching.

#### Tier 2: Community GitHub (top starred repos)
Search GitHub for highly starred skill repositories. Good queries:
- `claude skills topic:claude-skill`
- `SKILL.md claude anthropic`
- `claude-skills-registry`

Reference `references/github-search.md` for how to evaluate and surface community skills.

#### Tier 3: Official Anthropic Skills
Check the official Anthropic skills repository if one exists. Search for `anthropic/claude-skills` or similar official registry. Reference `references/official-registry.md` for guidance.

**Cross-check**: After collecting candidates from all tiers, **deduplicate by name**. If a skill exists locally, prefer the local version — no need to suggest reinstalling it.

---

### Step 3 — Match & Recommend

Match discovered skills to the project's stack and the requested scope. Present recommendations as a clean list:

```
📦 Recommended Skills for [Project Name / Scope]

✅ Already installed:
  - [skill-name] — [one-line description]

🆕 Available to install:
  1. [skill-name] (local) — [one-line description]
  2. [skill-name] (community ⭐ 342) — [one-line description]
  3. [skill-name] (official) — [one-line description]

❓ Possibly relevant (lower confidence):
  - [skill-name] — [one-line description]
```

Aim for 3–7 strong recommendations. Don't overwhelm — curate.

---

### Step 4 — Interactive Install

Ask the user which skills they want to install. Then ask:

> "Install as **user-scope** (available in all your projects) or **project-scope** (this project only)?"

| Scope | Path |
|---|---|
| User-scope | `/mnt/skills/user/[skill-name]/` |
| Project-scope | `.claude/skills/[skill-name]/` (relative to project root) |

For each selected skill:
1. Copy or fetch the skill files to the chosen path
2. Confirm installation with: `✅ [skill-name] installed to [path]`
3. If the skill has bundled resources (scripts/, references/, assets/), copy them too

After install, tell the user: "These skills will be available the next time Claude reads your project context."

---

### Step 5 — Update CLAUDE.md (optional)

Offer to update or create the project's `CLAUDE.md` with a skills section:

```markdown
## Installed Skills
- [skill-name]: [description]
```

Ask before writing. If the user says yes, append cleanly without overwriting existing content.

---

## Scope Behavior

When a scope argument is passed (e.g., `/openskill frontend`), skip Step 1's full codebase scan. Instead:
- Use the scope as the primary filter for discovery
- Still check the project root for CLAUDE.md to get stack context
- Focus Tier 1/2/3 searches on that domain

**Scope → keyword mapping:**
- `frontend` → React, Vue, Svelte, CSS, Tailwind, UI, components, design systems
- `backend` → Node, Python, Go, Rust, Express, FastAPI, Django, databases, auth
- `debug` → logging, tracing, error handling, stack traces, breakpoints
- `code-review` → linting, formatting, best practices, refactoring, PR review
- `api` → REST, GraphQL, OpenAPI, Swagger, Postman, endpoints
- `data` → pandas, SQL, ETL, spreadsheets, analytics, charts
- `infra` → Docker, Kubernetes, Terraform, CI/CD, AWS, GCP, Azure
- `testing` → Jest, Pytest, Playwright, Cypress, unit/integration/e2e tests

---

## Tone & UX

- Be concise. This is a CLI-style interaction — users expect fast, scannable output.
- Use emojis sparingly for status (✅ installed, 🆕 new, ❓ maybe, ⭐ community stars).
- Don't ask unnecessary clarifying questions. Read first, ask only if genuinely ambiguous.
- If nothing relevant is found, say so plainly and suggest the user try a different scope or check back later.

---

## Reference Files

- `references/github-search.md` — How to find and evaluate community skills on GitHub
- `references/official-registry.md` — How to check the official Anthropic skills registry
- `references/install-guide.md` — Detailed install path logic and edge cases
