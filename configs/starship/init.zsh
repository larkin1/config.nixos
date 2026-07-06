bindkey -v

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist

HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY

source "${0:A:h}/check.zsh"
source "${0:A:h}/aliases.zsh"
source "${0:A:h}/catppuccin_mocha-zsh-syntax-highlighting.zsh"
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export EDITOR=nvim
export VISUAL=nvim
export STARSHIP_CONFIG="${0:A:h}/starship.toml"

export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$GOBIN"

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
