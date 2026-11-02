autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
WORDCHARS=''

. "$HOME/.config/vite-plus/env"
eval "$(starship init zsh)"
preexec() { print; }
