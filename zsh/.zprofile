eval "$(/opt/homebrew/bin/brew shellenv zsh)"
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/rustup/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
