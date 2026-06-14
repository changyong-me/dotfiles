#!/bin/bash
set -euo pipefail

# Dock preferences
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock size-immutable -bool true

# Finder preferences
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Desktop preferences
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Keyboard preferences
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write com.apple.HIToolbox AppleFnUsageType -int 0
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Mission control preferences
defaults write com.apple.dock mru-spaces -bool false
