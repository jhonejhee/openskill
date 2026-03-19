# openskill

> A package manager for Claude skills. Project-aware skill discovery and interactive installer.

---

## What is it?

**openskill** is a Claude skill that acts like a package manager for other skills. It reads your project, discovers relevant Claude skills from multiple sources, and installs them interactively — scoped to your user or your project.

```
/openskill              → full project scan + discover + install
/openskill frontend     → frontend-scoped skill discovery
/openskill backend      → backend-scoped skill discovery
/openskill debug        → debugging skill discovery
/openskill code-review  → code review skill discovery
/openskill api          → API design skill discovery
/openskill data         → data/analytics skill discovery
/openskill infra        → DevOps/cloud skill discovery
/openskill testing      → testing skill discovery
```

---

## How it works

1. **Reads your project** — scans `CLAUDE.md`, `package.json`, framework configs, and other stack signals
2. **Discovers skills** from three tiers:
   - Local: already-available skills in your Claude install
   - Community: top-starred GitHub skill repos
   - Official: the Anthropic skills registry (if available)
3. **Cross-checks** against what's already installed — no duplicate suggestions
4. **Installs interactively** — choose user-scope (all projects) or project-scope (this project only)
5. **Optionally updates `CLAUDE.md`** with a skills section for your team

---

## Installation

### Option A: Install via Claude (recommended)

**Claude.ai** — in any Claude session with file access, paste this prompt:

```
Please install the openskill skill from https://github.com/jhonejhee/openskill
into /mnt/skills/user/openskill so it's available in all my projects.
```

**Claude Code** — in any Claude Code session, paste this prompt:

```
Please install the openskill skill from https://github.com/jhonejhee/openskill
into ~/.claude/skills/openskill so it's available in all my projects.
```

### Option B: Manual install (user-scope)

```bash
# Clone the repo
git clone https://github.com/jhonejhee/openskill
```

**Claude Code:**
```bash
cp -r openskill/openskill ~/.claude/skills/openskill
```

**Claude.ai:**
```bash
cp -r openskill/openskill /mnt/skills/user/openskill
```

| Environment | Skills path |
|---|---|
| Claude Code | `~/.claude/skills/` |
| Claude.ai | `/mnt/skills/user/` |

### Option C: Manual install (project-scope)

```bash
# From your project root:
mkdir -p .claude/skills
cp -r path/to/openskill/openskill .claude/skills/openskill
```

> Project-scope works the same in both Claude Code and Claude.ai.

---

## Getting Started

Before using `/openskill`, set up your project context by running:
```
/init
```

This creates a `CLAUDE.md` in your project root — a file Claude reads to understand your stack, conventions, and installed skills. Once it exists, `/openskill` will use it to give you better, more relevant skill recommendations.

## Usage

Once installed, just type in any Claude session:

```
/openskill
```

Claude will scan your project and walk you through discovery and installation interactively.

**Scoped lookup:**

```
/openskill frontend
```

Skips the full project scan and focuses only on frontend-relevant skills.

---

## Skill Structure

This repo follows the standard Claude skill format:

```
openskill/
├── SKILL.md                        # Main skill instructions + YAML frontmatter
└── references/
    ├── github-search.md            # How to search and evaluate community skills
    ├── official-registry.md        # How to check the Anthropic official registry
    └── install-guide.md            # Install path logic and conflict handling
```

---

## Contributing Your Own Skill

Want your skill to be discoverable by openskill?

1. Create a public GitHub repo with a valid `SKILL.md` at the root or in a named subdirectory
2. Add the topic `claude-skill` to your repo
3. Make sure your `SKILL.md` has valid YAML frontmatter with `name` and `description`
4. Star count and recency affect discovery priority

### Minimal valid skill structure

```
my-skill/
└── SKILL.md
```

```markdown
---
name: my-skill
description: What this skill does and when Claude should use it.
---

# My Skill

Instructions for Claude go here...
```

### Submit to the registry (optional)

Open a PR to add your skill to `registry/community.yaml` in this repo:

```yaml
- name: my-skill
  description: One-line description
  repo: github.com/you/my-skill
  path: my-skill/
  tags: [frontend, react, css]
```

---

## Roadmap

- [ ] `registry/community.yaml` — curated community skill index
- [ ] `/openskill list` — show all installed skills
- [ ] `/openskill remove` — uninstall a skill
- [ ] `/openskill update` — refresh skills from source
- [ ] `/openskill search <query>` — free-text skill search
- [ ] Web UI for browsing the registry

---

## License

MIT — use it, fork it, build on it.

---

## Credits

Built with [Claude](https://claude.ai) skills system. Inspired by package managers like `npm`, `brew`, and `pip` — but for AI behavior.