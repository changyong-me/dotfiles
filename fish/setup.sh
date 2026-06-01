mkdir -p ~/.config/fish
ln -snf ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -snf ~/.dotfiles/fish/starship.toml ~/.config/starship.toml

if ! grep -qxF /opt/homebrew/bin/fish /etc/shells; then
  echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells >/dev/null
fi

chsh -s /opt/homebrew/bin/fish
