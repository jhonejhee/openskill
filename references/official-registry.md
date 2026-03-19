# Official Anthropic Skills Registry

## How to Check

Search for the official Anthropic skill registry with:
- `github.com/anthropics/claude-skills`
- `docs.claude.ai skills registry`
- Web search: `anthropic official claude skills registry`

If an official registry exists, it will likely expose a JSON or YAML index of available skills. Fetch that index, then filter by relevance to the project's stack.

## Expected Format

An official registry index may look like:

```json
[
  {
    "name": "docx",
    "description": "...",
    "url": "https://...",
    "tags": ["documents", "word", "office"]
  }
]
```

Parse the `name`, `description`, and `tags` fields for matching.

## If No Official Registry Exists

Note this to the user briefly:
> "No official Anthropic skills registry found — showing local and community results only."

Don't treat this as an error. Just proceed with Tier 1 and Tier 2 results.

## Presenting Official Skills

Label them clearly:
```
🆕 pdf-toolkit (official) — Extract, merge, and annotate PDF files
   → docs.claude.ai/skills/pdf-toolkit
```
