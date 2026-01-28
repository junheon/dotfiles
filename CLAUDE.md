# Dotfiles Project Guide

## Structure
- chezmoi-based dotfiles with symlink from `~/.local/share/chezmoi`
- Shell: Zsh + Antidote (plugin manager) + Powerlevel10k
- `dot_` prefix = chezmoi naming convention for dotfiles

## Key Directories
- `dot_config/zsh/` - Zsh configuration (aliases, keybindings)
- `dot_config/nvim/` - Neovim (LazyVim)
- `dot_config/ghostty/` - Ghostty terminal
- `dot_config/git/` - Git global config
- `dot_config/zed/` - Zed editor
- `dot_claude/` - Claude Code settings

## Commands
- `chezmoi apply` - Apply changes to home directory
- `chezmoi diff` - Preview changes before applying
- `chezmoi edit <file>` - Edit a managed file
- `chezmoi add <file>` - Add a new file to management
