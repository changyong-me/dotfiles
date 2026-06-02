mkdir -p ~/.codex/skills
ln -snf ~/.dotfiles/codex/skills ~/.codex/skills/user
ln -snf ~/.dotfiles/codex/AGENTS.md ~/.codex/AGENTS.md
cp -f ~/.dotfiles/codex/config.toml ~/.codex/config.toml

npx skills add https://github.com/mattpocock/skills \
  -s diagnose grill-me handoff prototype tdd \
  -g -a codex -y
