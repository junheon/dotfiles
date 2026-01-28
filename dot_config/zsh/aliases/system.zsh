# System aliases

# Listing
if [[ "$(uname)" == "Darwin" ]]; then
  alias ll='ls -alGh'
  alias ls='ls -Gh'
else
  alias ll='ls -alh --color=auto'
  alias ls='ls --color=auto'
fi
alias lsg='ll | grep'
alias lh='ls -alt | head'

# Process
alias psa='ps aux'
alias psg='ps aux | grep'
alias ka9='killall -9'
alias k9='kill -9'

# Disk
alias df='df -h'
alias du='du -h -d 2'

# Misc
alias cl='clear'
alias cls='clear; ls'
alias less='less -r'
alias tf='tail -f'

# Homebrew
alias brewu='brew update && brew upgrade && brew cleanup && brew doctor'
