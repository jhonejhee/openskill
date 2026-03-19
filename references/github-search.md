# GitHub Community Skill Discovery

When searching GitHub for community skills, use web search with these strategies:

## Search Queries (in order of reliability)

1. `site:github.com SKILL.md claude-skill stars:>50`
2. `github claude skills registry SKILL.md`
3. `github.com/topics/claude-skill`
4. `anthropic claude SKILL.md community skills`

## What Makes a Good Community Skill

When evaluating a GitHub repo as a skill source, look for:

- ✅ Has a valid `SKILL.md` with YAML frontmatter (`name`, `description`)
- ✅ Star count > 20 (signals real-world use)
- ✅ Recently updated (within 6 months)
- ✅ Has a clear README explaining what it does
- ✅ Optional but good: has test prompts or examples

Avoid:
- ❌ Repos with no stars and no README
- ❌ Skills with vague descriptions that don't explain when to trigger
- ❌ Repos that are just forks with no changes

## How to Surface Skills

When you find a GitHub repo containing skills:
1. Navigate to the repo root or a `skills/` subdirectory
2. Find all `SKILL.md` files
3. Read only the YAML frontmatter (lines between `---` markers at the top)
4. Extract `name` and `description` — that's enough to match to a project

## Presenting Community Skills

Always show:
- Skill name
- One-line description (from frontmatter)
- GitHub repo URL
- Star count if available
- Source label: `(community ⭐ [count])`

Example:
```
🆕 docx-formatter (community ⭐ 134) — Formats and styles Word documents with custom templates
   → github.com/someone/claude-docx-skill
```

## Known Community Registries (check these first)

If an openskill community registry has been established, it will likely be at one of:
- `github.com/openskill-dev/registry`
- `github.com/topics/openskill`
- A pinned list in the openskill GitHub repo

Check the openskill repo's own README for up-to-date registry links.
