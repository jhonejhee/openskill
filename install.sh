#!/bin/bash

set -e

REPO="https://github.com/jhonejhee/openskill"
RAW="https://raw.githubusercontent.com/jhonejhee/openskill/main"
SKILL_NAME="openskill"

echo "🔍 Detecting environment..."

# Detect Claude.ai vs Claude Code
if [ -d "/mnt/skills" ]; then
  ENV="claudeai"
  USER_PATH="/mnt/skills/user/$SKILL_NAME"
  echo "✅ Detected: Claude.ai"
else
  ENV="claudecode"
  USER_PATH="$HOME/.claude/skills/$SKILL_NAME"
  echo "✅ Detected: Claude Code"
fi

echo ""
echo "📦 Installing openskill to: $USER_PATH"
echo ""

# Create target directory
mkdir -p "$USER_PATH/references"

# Fetch SKILL.md
echo "⬇️  Fetching SKILL.md..."
curl -fsSL "$RAW/SKILL.md" -o "$USER_PATH/SKILL.md"

# Fetch reference files
echo "⬇️  Fetching references..."
curl -fsSL "$RAW/references/github-search.md" -o "$USER_PATH/references/github-search.md"
curl -fsSL "$RAW/references/official-registry.md" -o "$USER_PATH/references/official-registry.md"
curl -fsSL "$RAW/references/install-guide.md" -o "$USER_PATH/references/install-guide.md"

echo ""
echo "✅ openskill installed to $USER_PATH"
echo ""
echo "Usage:"
echo "  /openskill              → full project scan + discover + install"
echo "  /openskill frontend     → frontend-scoped discovery"
echo "  /openskill backend      → backend-scoped discovery"
echo "  /openskill <scope>      → any scope: debug, api, data, infra, testing, code-review"
echo ""
echo "Tip: Run /init first to create a CLAUDE.md for better skill recommendations."