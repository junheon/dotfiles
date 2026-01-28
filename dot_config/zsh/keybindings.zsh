# Vi mode
bindkey -v

# Emacs-style line editing in vi mode
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^r' history-incremental-search-backward
bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search

# History substring search (requires zsh-history-substring-search)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Reduce vi mode switch delay
export KEYTIMEOUT=1
