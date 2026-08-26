#!/bin/bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/changyong-me/dotfiles.git"

link() {
  mkdir -p "$(dirname "$2")"
  ln -sfn "$1" "$2"
}

copy() {
  mkdir -p "$(dirname "$2")"
  cp "$1" "$2"
}

bootstrap() {
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  if [ -d "$DOTFILES/.git" ]; then
    git -C "$DOTFILES" pull --ff-only
  else
    git clone "$DOTFILES_REPO" "$DOTFILES"
  fi

  bash "$DOTFILES/macos/defaults.sh"
  brew bundle --file="$DOTFILES/macos/Brewfile"
  rustup default stable

  link  "$DOTFILES/claude/CLAUDE.md"         "$HOME/.claude/CLAUDE.md"
  link  "$DOTFILES/claude/settings.json"     "$HOME/.claude/settings.json"
  link  "$DOTFILES/codex/AGENTS.md"          "$HOME/.codex/AGENTS.md"
  copy  "$DOTFILES/codex/config.toml"        "$HOME/.codex/config.toml"
  link  "$DOTFILES/git/.gitconfig"           "$HOME/.gitconfig"
  link  "$DOTFILES/git/ignore"               "$HOME/.config/git/ignore"
  link  "$DOTFILES/karabiner/rules.json"     "$HOME/.config/karabiner/assets/complex_modifications/rules.json"
  link  "$DOTFILES/shell/.zprofile"          "$HOME/.zprofile"
  link  "$DOTFILES/shell/config.fish"        "$HOME/.config/fish/config.fish"
  link  "$DOTFILES/shell/starship.toml"      "$HOME/.config/starship.toml"
  link  "$DOTFILES/zed/keymap.json"          "$HOME/.config/zed/keymap.json"
  link  "$DOTFILES/zed/settings.macos.jsonc" "$HOME/.config/zed/settings.json"

  echo
  echo "Bootstrap completed successfully!"
  echo "Please restart your computer to apply all settings."
}

bootstrap "$@"
