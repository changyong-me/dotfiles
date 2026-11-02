eval "$(/opt/homebrew/bin/brew shellenv zsh)"
export PATH="$HOMEBREW_PREFIX/opt/rustup/bin:$PATH"
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
