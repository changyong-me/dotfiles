autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
WORDCHARS=''

alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -lAh'

eval "$(starship init zsh)"
preexec() { print; }
