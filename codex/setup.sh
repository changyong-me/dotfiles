mkdir -p ~/.codex/skills
ln -snf ~/.dotfiles/codex/skills ~/.codex/skills/user
ln -snf ~/.dotfiles/codex/AGENTS.md ~/.codex/AGENTS.md
ln -snf ~/.dotfiles/codex/config.toml ~/.codex/config.toml

npx --yes skills add https://github.com/forrestchang/andrej-karpathy-skills --skill karpathy-guidelines --global --agent codex --yes
npx --yes skills add https://github.com/mattpocock/skills --skill tdd --global --agent codex --yes
npx --yes skills add https://github.com/anthropics/skills --skill frontend-design --global --agent codex --yes

# Set clean filter to ignore trust entries
git -C ~/.dotfiles config filter.codex-config.clean "head -n 13"
git -C ~/.dotfiles config filter.codex-config.smudge cat
