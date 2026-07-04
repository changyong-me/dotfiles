#!/bin/bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/changyong-me/dotfiles.git"
FISH="/opt/homebrew/bin/fish"

link() {
  mkdir -p "$(dirname "$2")"
  ln -sfn "$1" "$2"
}

copy() {
  mkdir -p "$(dirname "$2")"
  cp "$1" "$2"
}

require() {
  command -v "$1" >/dev/null 2>&1 && return
  echo "$1: command not found" >&2
  exit 1
}

bootstrap() {
  if ! command -v brew >/dev/null 2>&1; then
    sudo -v
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  if [ -d "$DOTFILES/.git" ]; then
    git -C "$DOTFILES" pull --ff-only
  else
    git clone "$DOTFILES_REPO" "$DOTFILES"
  fi

  bash "$DOTFILES/macos/defaults.sh"

  require brew
  brew bundle --file="$DOTFILES/macos/Brewfile"

  require fnm
  fnm install --lts
  fnm default lts-latest

  require rustup
  rustup default stable

  if ! command -v claude >/dev/null 2>&1; then
    curl -fsSL https://claude.ai/install.sh | bash
  fi

  if ! grep -q "$FISH" /etc/shells; then
    echo "$FISH" | sudo tee -a /etc/shells >/dev/null
  fi

  if [ "$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')" != "$FISH" ]; then
    sudo chsh -s "$FISH" "$USER"
  fi

  link  "$DOTFILES/claude/CLAUDE.md"     "$HOME/.claude/CLAUDE.md"
  link  "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"
  link  "$DOTFILES/codex/AGENTS.md"      "$HOME/.codex/AGENTS.md"
  copy  "$DOTFILES/codex/config.toml"    "$HOME/.codex/config.toml"
  link  "$DOTFILES/codex/skills"         "$HOME/.codex/skills/user"
  link  "$DOTFILES/git/.gitconfig"       "$HOME/.gitconfig"
  link  "$DOTFILES/git/ignore"           "$HOME/.config/git/ignore"
  link  "$DOTFILES/karabiner/rules.json" "$HOME/.config/karabiner/assets/complex_modifications/rules.json"
  link  "$DOTFILES/shell/.zprofile"      "$HOME/.zprofile"
  link  "$DOTFILES/shell/config.fish"    "$HOME/.config/fish/config.fish"
  link  "$DOTFILES/shell/starship.toml"  "$HOME/.config/starship.toml"
  link  "$DOTFILES/zed/keymap.json"      "$HOME/.config/zed/keymap.json"
  link  "$DOTFILES/zed/settings.json"    "$HOME/.config/zed/settings.json"
  touch "$HOME/.hushlogin"

  echo
  echo "Bootstrap completed successfully!"
  echo "Please restart your computer to apply all settings."
}

bootstrap "$@"
