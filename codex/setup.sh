mkdir -p ~/.codex/skills
ln -snf ~/.dotfiles/codex/skills ~/.codex/skills/user
ln -snf ~/.dotfiles/codex/AGENTS.md ~/.codex/AGENTS.md
ln -snf ~/.dotfiles/codex/config.toml ~/.codex/config.toml

npx skills add https://github.com/mattpocock/skills --skill tdd -g -a codex -y

# Set clean filter to ignore trust entries
git -C ~/.dotfiles config filter.codex-config.clean "head -n 8"
git -C ~/.dotfiles config filter.codex-config.smudge cat
