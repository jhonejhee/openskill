# Skill Install Path Logic

## Scope Decision

Always ask the user before installing:

> "Install as **user-scope** (available across all your projects) or **project-scope** (this project only)?"

## Path Rules

### User-Scope
- Target: `/mnt/skills/user/[skill-name]/`
- Available in all Claude sessions for this user
- Good for general-purpose skills (docx, pdf, code-review, etc.)

### Project-Scope
- Target: `.claude/skills/[skill-name]/` (relative to project root)
- Only active when Claude is used in this project's directory
- Good for project-specific workflows or experimental skills
- Add `.claude/skills/` to `.gitignore` if the skills are personal; commit it if the team should share them

## Installing from Local (Tier 1)

Skills already in `/mnt/skills/public/` or `/mnt/skills/examples/` are read-only.
To "install" them:
1. Copy the full skill directory to the user or project path
2. Confirm the copy succeeded

```bash
cp -r /mnt/skills/public/[skill-name] /mnt/skills/user/[skill-name]
# or
cp -r /mnt/skills/public/[skill-name] .claude/skills/[skill-name]
```

## Installing from GitHub (Tier 2 & 3)

1. Fetch the raw `SKILL.md` URL from GitHub (use raw.githubusercontent.com)
2. If the skill has a `references/` or `scripts/` folder, fetch those too
3. Write them to the target install path
4. Confirm each file written

For a single-file skill:
```
GET https://raw.githubusercontent.com/[user]/[repo]/main/[skill-name]/SKILL.md
→ write to [install-path]/SKILL.md
```

For multi-file skills, recursively fetch the directory tree using the GitHub API:
```
GET https://api.github.com/repos/[user]/[repo]/contents/[skill-name]
```

## Post-Install Checklist

After installing each skill:
- [ ] `SKILL.md` exists at the install path
- [ ] YAML frontmatter is valid (has `name` and `description`)
- [ ] Bundled resources copied if present
- [ ] User informed of the install path
- [ ] Offered to update `CLAUDE.md` if the project has one

## Handling Conflicts

If a skill with the same name already exists at the target path:
- Tell the user: "A skill named `[name]` is already installed at `[path]`."
- Ask: "Overwrite, skip, or install as `[name]-v2`?"
- Never silently overwrite.

## Uninstalling

If the user asks to remove a skill (or via future `/openskill remove`):
- Confirm before deleting: "Remove `[skill-name]` from `[path]`? This cannot be undone."
- Delete the entire skill directory
- Offer to update `CLAUDE.md` to remove the reference
