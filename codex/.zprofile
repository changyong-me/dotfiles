eval "$(/opt/homebrew/bin/brew shellenv)"
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell zsh)"

export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
