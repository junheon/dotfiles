#!/bin/bash

# Dotfiles Auto-Sync Script
# Runs every 30 minutes via launchd to sync config changes

LOG_DIR="$HOME/Library/Logs/dotfiles-sync"
LOG_FILE="$LOG_DIR/sync.log"
DOTFILES_DIR="$HOME/workspace/personal/dotfiles"

# Create log directory
mkdir -p "$LOG_DIR"

# Log function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Change to dotfiles directory
cd "$DOTFILES_DIR" || {
    log "ERROR: Cannot change to $DOTFILES_DIR"
    exit 1
}

log "=== Starting sync ==="

# Pull latest changes from remote
log "Pulling latest changes..."
if git pull --rebase origin main >> "$LOG_FILE" 2>&1; then
    log "Pull successful"
else
    log "WARNING: Pull had issues, continuing..."
fi

# Update Brewfile
log "Updating Brewfile..."
if brew bundle dump --force --file="$DOTFILES_DIR/Brewfile" >> "$LOG_FILE" 2>&1; then
    log "Brewfile updated"
else
    log "WARNING: Brewfile update failed"
fi

# Check for local changes
if ! git diff --quiet; then
    # Get list of changed files
    CHANGED_FILES=$(git diff --name-only | head -10)
    FILE_COUNT=$(git diff --name-only | wc -l | tr -d ' ')

    log "Changes detected in $FILE_COUNT files"
    log "Files: $CHANGED_FILES"

    # Show macOS notification
    osascript -e "display notification \"Dotfiles sync: $FILE_COUNT files changed\" with title \"Dotfiles Auto-Sync\"" 2>/dev/null

    # Commit changes
    log "Committing changes..."
    git add . >> "$LOG_FILE" 2>&1

    git commit -m "Auto-sync: $(date '+%Y-%m-%d %H:%M')

Changed files:
$CHANGED_FILES" >> "$LOG_FILE" 2>&1

    if [ $? -eq 0 ]; then
        log "Commit successful"

        # Push to remote
        log "Pushing to remote..."
        if git push origin main >> "$LOG_FILE" 2>&1; then
            log "Push successful"
        else
            log "ERROR: Push failed"
        fi
    else
        log "ERROR: Commit failed"
    fi

    log "=== Sync completed ==="
else
    log "No changes detected"
    log "=== Sync completed (no action) ==="
fi
