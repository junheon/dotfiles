# Git aliases (migrated from YADR, selected for daily use)

# Status & Diff
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached -w'
alias gds='git diff --staged -w'
alias gsh='git show'

# Branch
alias gb='git branch -v'
alias gco='git checkout'
alias gnb='git checkout -b'

# Log
alias gl='git log --graph --date=short'

# Add & Commit
alias ga='git add -A'
alias gap='git add -p'
alias gci='git commit'
alias gcm='git commit -m'
alias gam='git amend --reset-author'

# Push & Pull
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gpsh='git push -u origin $(git rev-parse --abbrev-ref HEAD)'

# Fetch
alias gf='git fetch'
alias gfp='git fetch --prune'

# Stash
alias gstsh='git stash'
alias gst='git stash'
alias gsp='git stash pop'
alias gsa='git stash apply'

# Rebase
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gbi='git rebase --interactive'

# Merge
alias gm='git merge'
alias gms='git merge --squash'

# Cleanup
alias gdmb='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
