autoload -Uz compinit && compinit
. "$HOME/.config/vite-plus/env"
eval "$(starship init zsh)"
preexec() { print; }
