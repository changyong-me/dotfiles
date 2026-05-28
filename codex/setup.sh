mkdir -p ~/.codex
ln -snf ~/.dotfiles/codex/.zprofile ~/.zprofile
ln -snf ~/.dotfiles/codex/AGENTS.md ~/.codex/AGENTS.md

npx skills add https://github.com/mattpocock/skills \
  -s diagnose grill-with-docs handoff improve-codebase-architecture prototype \
  -s review setup-matt-pocock-skills tdd to-issues to-prd triage zoom-out \
  -g -a codex -y
