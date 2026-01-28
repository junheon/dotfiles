# Dotfiles

macOS 개발 환경 설정 (chezmoi 기반)

## 개발 환경 개요

### AI 코딩 도구
- **Google Antigravity**: AI-first IDE (수동 설치: antigravity.google)
- **Claude Code**: CLI AI 어시스턴트
- **Zed (z.ai)**: AI 통합 에디터

### 에디터 & 터미널
- **VS Code**: 범용 에디터 (Settings Sync 사용)
- **Neovim (LazyVim)**: 터미널 에디터
- **Ghostty**: 주 터미널
- **Zellij**: 터미널 멀티플렉서

### 패키지 매니저
- **Homebrew**: macOS 시스템 패키지
- **Volta + pnpm**: Node.js 버전 및 패키지 관리
- **Bun**: JavaScript 런타임
- **uv**: Python 패키지 관리 (moai-adk 등)

### 컨테이너
- **Docker**: 개발 환경 컨테이너화

## 빠른 시작

새 Mac에서:

```bash
# 1. chezmoi 설치
brew install chezmoi

# 2. dotfiles 적용
chezmoi init --apply <github-username>

# 3. 수동 설치 필요 항목
# - Google Antigravity: https://antigravity.google/download
# - moai-adk: uv tool install moai-adk
```

## 디렉토리 구조

```
dotfiles/
├── .chezmoi.toml.tmpl       # 머신별 설정 (이름, 이메일 등)
├── Brewfile                 # Homebrew 패키지
├── dot_zshenv               # ZDOTDIR 설정
├── dot_config/
│   ├── zsh/                 # Zsh 설정 (antidote + p10k)
│   │   ├── dot_zshrc
│   │   ├── dot_zsh_plugins.txt
│   │   ├── aliases/         # git, system, navigation
│   │   └── keybindings.zsh
│   ├── nvim/                # Neovim (LazyVim)
│   ├── ghostty/             # Ghostty 터미널
│   ├── git/                 # Git 전역 설정
│   ├── zed/                 # Zed 에디터
│   └── zellij/              # Zellij 멀티플렉서
└── dot_claude/              # Claude Code 설정
```

## 커스터마이징

### 머신별 설정

`chezmoi init` 시 다음 항목을 프롬프트합니다:
- 이름, 이메일
- 회사 머신 여부 (`isWorkMachine`)

### Zsh 플러그인 추가

`dot_config/zsh/dot_zsh_plugins.txt`에 antidote 형식으로 추가:
```
author/plugin-name
```

### Alias 추가

`dot_config/zsh/aliases/` 디렉토리에 `*.zsh` 파일 추가

## 롤백

문제 발생 시:
```bash
# YADR 복원
rm -rf ~/.yadr && mv ~/.yadr.backup.YYYYMMDD ~/.yadr
mv ~/.zshrc.backup.YYYYMMDD ~/.zshrc
rm -rf ~/.zprezto && mv ~/.zprezto.backup.YYYYMMDD ~/.zprezto
exec zsh
```
