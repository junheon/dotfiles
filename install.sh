#!/bin/bash

# Dotfiles Installation Script
# 새 노트북에서 개발 환경을 빠르게 설정

set -e  # Exit on error

echo "🚀 Starting dotfiles installation..."

# 현재 스크립트의 디렉토리 경로
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 1. Homebrew 설치 확인
echo "📦 Checking Homebrew installation..."
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✓ Homebrew already installed"
fi

# 2. Brewfile로 패키지 설치
echo "📦 Installing packages from Brewfile..."
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    cd "$DOTFILES_DIR"
    brew bundle install
    echo "✓ Packages installed"
else
    echo "⚠️  Brewfile not found, skipping package installation"
fi

# 3. Hammerspoon 심링크 생성
echo "🔗 Creating Hammerspoon symlink..."
if [ -e ~/.hammerspoon ]; then
    if [ -L ~/.hammerspoon ]; then
        echo "✓ Symlink already exists"
    else
        echo "Backing up existing ~/.hammerspoon to ~/.hammerspoon.backup"
        mv ~/.hammerspoon ~/.hammerspoon.backup
        ln -s "$DOTFILES_DIR/hammerspoon" ~/.hammerspoon
        echo "✓ Symlink created"
    fi
else
    ln -s "$DOTFILES_DIR/hammerspoon" ~/.hammerspoon
    echo "✓ Symlink created"
fi

# 4. 완료 메시지
echo ""
echo "✅ Dotfiles installation complete!"
echo ""
echo "Next steps:"
echo "  1. Reload Hammerspoon (⌘⌃R)"
echo "  2. Check that input source switching works"
echo ""
echo "To add more dotfiles:"
echo "  - Add config files to $DOTFILES_DIR"
echo "  - Create symlinks in install.sh"
echo "  - Update Brewfile: brew bundle dump --file=$DOTFILES_DIR/Brewfile"
echo ""
