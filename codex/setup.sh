mkdir -p ~/.codex/skills
ln -snf ~/.dotfiles/codex/skills ~/.codex/skills/user
ln -snf ~/.dotfiles/codex/AGENTS.md ~/.codex/AGENTS.md
ln -snf ~/.dotfiles/codex/config.toml ~/.codex/config.toml

npx skills add https://github.com/mattpocock/skills \
  -s grill-with-docs improve-codebase-architecture tdd \
  -g -a codex -y
