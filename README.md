# Dotfiles

macOS 개발 환경 설정 (chezmoi 기반)

## 개발 환경 개요

| 카테고리 | 도구 | 설명 |
|---------|------|------|
| **Shell** | Zsh + Antidote | 플러그인 관리자 |
| | Starship | 크로스쉘 프롬프트 |
| **터미널** | Ghostty | 주 터미널 |
| | Zellij | 멀티플렉서 |
| **에디터** | Neovim (LazyVim) | 터미널 에디터 |
| | VS Code | 범용 에디터 |
| | Zed | AI 통합 에디터 |
| **AI 도구** | Claude Code | CLI AI 어시스턴트 |
| | Google Antigravity | AI-first IDE |
| **Node.js** | Volta | 버전 관리 |
| | pnpm | 패키지 관리 |
| | Bun | JS 런타임 |
| **Python** | uv | 패키지 관리 |
| **컨테이너** | Docker | 개발 환경 |
| **Git** | lazygit, delta | TUI, diff 도구 |

## Shell 스택

| 계층 | 도구 | 역할 |
|------|------|------|
| Shell | Zsh | 기본 셸 |
| Plugin Manager | Antidote | Zsh 플러그인 관리 |
| Prompt | Starship | 크로스플랫폼 프롬프트 |
| Completions | zsh-completions | 명령어 자동완성 |
| Suggestions | zsh-autosuggestions | 히스토리 기반 제안 |
| Highlighting | zsh-syntax-highlighting | 문법 하이라이팅 |
| History Search | zsh-history-substring-search | 히스토리 검색 |
| Directory Jump | zoxide | 스마트 디렉토리 이동 |
| Fuzzy Finder | fzf | 퍼지 검색 통합 |

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
│   ├── zsh/                 # Zsh 설정 (antidote + starship)
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

### Zellij 설정

Claude Code와 호환되도록 구성:

| 설정 | 값 | 설명 |
|------|-----|------|
| 테마 | solarized-dark | 다크 테마 |
| 기본 모드 | locked | 모든 키가 앱으로 전달 |
| 모드 전환 | `Ctrl+G` | zellij unlocked 모드 진입 |

**별칭**:
| 별칭 | 명령어 | 설명 |
|------|--------|------|
| `zj` | `zellij attach -c` | 기존 세션 연결 또는 새로 생성 |
| `zjn` | `zellij` | 항상 새 세션 |
| `zjs` | `zellij list-sessions` | 세션 목록 |

**사용법**:
- `zj`로 zellij 시작 (기존 세션 있으면 연결, 없으면 새로 생성)
- 기본 상태에서 Claude Code의 `Ctrl+O`, `Ctrl+T` 등 단축키 정상 작동
- `Ctrl+G` 누르면 zellij 모드 진입 → `p`(Pane), `t`(Tab), `n`(Resize) 등 사용 가능

## 롤백

문제 발생 시:
```bash
# YADR 복원
rm -rf ~/.yadr && mv ~/.yadr.backup.YYYYMMDD ~/.yadr
mv ~/.zshrc.backup.YYYYMMDD ~/.zshrc
rm -rf ~/.zprezto && mv ~/.zprezto.backup.YYYYMMDD ~/.zprezto
exec zsh
```
