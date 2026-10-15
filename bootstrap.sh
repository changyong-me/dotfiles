#!/bin/bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/changyong-me/dotfiles.git"

symlink() {
  mkdir -p "$(dirname "$2")"
  if [ -d "$2" ] && [ ! -L "$2" ]; then rmdir "$2"; fi
  ln -sfn "$1" "$2"
}

get_dotfiles() {
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  if [ -d "$DOTFILES/.git" ]; then
    git -C "$DOTFILES" pull --ff-only
  else
    git clone "$DOTFILES_REPO" "$DOTFILES"
  fi
}

install_dotfiles() {
  bash "$DOTFILES/macos/defaults.sh"
  brew bundle --file="$DOTFILES/macos/Brewfile"
  rustup default stable
  vp env setup

  if [ -d /Applications/Xcode.app ]; then
    sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
    sudo xcodebuild -license accept
    sudo xcodebuild -runFirstLaunch
  fi

  symlink "$DOTFILES/claude/skills"            "$HOME/.claude/skills"
  symlink "$DOTFILES/claude/CLAUDE.md"         "$HOME/.claude/CLAUDE.md"
  symlink "$DOTFILES/claude/settings.json"     "$HOME/.claude/settings.json"
  symlink "$DOTFILES/git/.gitconfig"           "$HOME/.gitconfig"
  symlink "$DOTFILES/git/ignore"               "$HOME/.config/git/ignore"
  symlink "$DOTFILES/karabiner/rules.json"     "$HOME/.config/karabiner/assets/complex_modifications/rules.json"
  symlink "$DOTFILES/shell/.zprofile"          "$HOME/.zprofile"
  symlink "$DOTFILES/shell/config.fish"        "$HOME/.config/fish/config.fish"
  symlink "$DOTFILES/shell/starship.toml"      "$HOME/.config/starship.toml"
  symlink "$DOTFILES/zed/keymap.json"          "$HOME/.config/zed/keymap.json"
  symlink "$DOTFILES/zed/settings.macos.jsonc" "$HOME/.config/zed/settings.json"
}

bootstrap() {
  get_dotfiles
  install_dotfiles

  echo
  echo "Bootstrap completed successfully!"
  echo "Please restart your computer to apply all settings."
}

bootstrap "$@"
