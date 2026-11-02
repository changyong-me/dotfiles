eval "$(/opt/homebrew/bin/brew shellenv zsh)"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/rustup/bin:$PATH"
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
