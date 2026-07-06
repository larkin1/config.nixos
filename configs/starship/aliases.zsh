if command -v eza &>/dev/null; then
    alias ls='eza --icons'
    alias ll='eza -l --icons'
    alias la='eza -la --icons'
    alias lt='eza --tree --icons'
    alias lta='eza --tree --icons -a'
else
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -la --color=auto'
    if command -v tree &>/dev/null; then
        alias lt='tree'
    fi
fi

if command -v bat &>/dev/null; then
    alias cat='bat -n --paging=never'
fi

if command -v bat &>/dev/null; then
    alias less='bat -n --paging=always'
fi
