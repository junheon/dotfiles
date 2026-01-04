# Dotfiles

개인 macOS 개발 환경 설정을 관리하는 dotfiles 저장소

## 프로젝트 개요

이 저장소는 macOS 개발 환경을 효율적으로 관리하고, 새 노트북에서 빠르게 환경을 복원하기 위한 dotfiles 모음입니다.

**주요 목적:**
- Hammerspoon, shell 설정 등을 버전 관리
- Homebrew 패키지 목록 관리 (Brewfile)
- 새 노트북에서 자동화된 환경 복원
- 심볼릭 링크를 통한 설정 파일 관리

## 프로젝트 구조

```
~/workspace/personal/dotfiles/ (원본 - git repo)
├── .git/
├── .gitignore
├── CLAUDE.md              # 이 파일 (Claude Code용 문서)
├── README.md              # 일반 사용자용 문서
├── Brewfile               # Homebrew 패키지 목록
├── install.sh             # 자동 설치 스크립트
├── hammerspoon/           # Hammerspoon 자동화 설정
│   ├── init.lua
│   └── input-source-switcher.lua
└── config/                # ~/.config 디렉토리 설정
    ├── nvim/              # Neovim (LazyVim)
    ├── git/               # Git 전역 설정
    ├── fish/              # Fish shell
    └── zellij/            # Terminal multiplexer

심볼릭 링크:
~/.hammerspoon → ~/workspace/personal/dotfiles/hammerspoon/
~/.config → ~/workspace/personal/dotfiles/config/
```

**원본 vs 심볼릭 링크:**
- **원본**: `~/workspace/personal/dotfiles/` (git으로 관리)
- **심볼릭 링크**: `~/.hammerspoon` 등 (앱이 기대하는 위치)

## 주요 기능

### 1. 개발 도구 설정 관리 (~/.config)
- **Neovim**: LazyVim 설정 (keymaps, plugins, options)
- **Git**: 전역 gitignore 및 설정
- **Fish**: Shell 환경 설정
- **Zellij**: Terminal multiplexer 키바인딩 및 플러그인

### 2. Hammerspoon 자동화
- **자동 입력 소스 전환**: 특정 앱에 포커스 시 자동으로 영어/한글 전환
- **현재 설정**: Ghostty 앱 포커스 시 영어로 자동 전환

### 3. Homebrew 패키지 관리
- Brewfile로 모든 설치된 패키지 추적
- `brew bundle install`로 새 노트북에서 빠른 복원
- `brew bundle dump`로 패키지 목록 업데이트

### 4. 자동화된 설치
- `install.sh` 스크립트로 원클릭 환경 구성
- Homebrew 설치, 패키지 설치, 심볼릭 링크 생성 자동화

## 개발 가이드

### 새 설정 추가하기

#### 1. 설정 파일 추가
```bash
cd ~/workspace/personal/dotfiles
mkdir zsh
cp ~/.zshrc zsh/
```

#### 2. 심볼릭 링크 생성
```bash
rm ~/.zshrc
ln -s ~/workspace/personal/dotfiles/zsh/.zshrc ~/.zshrc
```

#### 3. install.sh 업데이트
`install.sh`에 심볼릭 링크 생성 코드 추가

#### 4. CLAUDE.md 업데이트
이 파일에 새 설정 섹션 추가

#### 5. Git 커밋
```bash
git add .
git commit -m "Add zsh configuration"
git push
```

### Brewfile 업데이트

새 패키지 설치 후:
```bash
cd ~/workspace/personal/dotfiles
brew bundle dump --force
git add Brewfile
git commit -m "Update Brewfile"
git push
```

### Git 워크플로우

```bash
# 설정 변경
vim hammerspoon/init.lua

# 변경 사항 커밋
git add .
git commit -m "Update hammerspoon config"
git push

# Hammerspoon 리로드
# ⌘⌃R
```

---

## ~/.config 상세

개발 도구 설정 파일들 (XDG Base Directory 표준)

### 포함된 설정

#### 1. Neovim (nvim/)
- **설정 유형**: LazyVim
- **주요 파일**:
  - `init.lua` - 메인 설정
  - `lua/config/` - keymaps, options, autocmds
  - `lua/plugins/` - 플러그인 설정
- **사용법**:
  ```bash
  nvim  # 설정이 자동으로 로드됨
  ```

#### 2. Git (git/)
- **파일**: `ignore` - 전역 gitignore
- **적용 범위**: 모든 Git 프로젝트
- **사용법**:
  ```bash
  # 자동으로 적용됨
  # 추가하려면: vim ~/.config/git/ignore
  ```

#### 3. Fish Shell (fish/)
- **파일**: `config.fish`, `conf.d/`, `functions/`
- **사용법**:
  ```bash
  fish  # Shell 시작 시 자동 로드
  ```
- **참고**: `fish_variables`는 .gitignore에서 제외됨 (런타임 생성)

#### 4. Zellij (zellij/)
- **파일**: `config.kdl` - 키바인딩 및 플러그인
- **사용법**:
  ```bash
  zellij  # 설정 자동 로드
  ```

### ~/.config 추가 설정

Phase 2로 추가 가능한 설정:
- `alacritty/` - Terminal emulator
- `ghostty/` - Modern terminal
- `zed/` - 에디터
- `gh/` - GitHub CLI (hosts.yml 제외)

Phase 3로 추가 가능한 설정:
- `broot/` - File browser
- `containers/` - Podman
- `uv/` - Python package manager

### 제외된 파일

.gitignore에서 자동 제외:
- `configstore/` - NPM 캐시
- `*/node_modules/` - Node 의존성
- `*/.local/` - 빌드 아티팩트
- `fish/fish_variables` - Shell 런타임 상태
- `**/*.bak` - 백업 파일

민감한 정보 제외:
- `gh/hosts.yml` - GitHub 토큰
- `rclone/` - 클라우드 인증 정보

---

## Hammerspoon 상세

Hammerspoon 자동화 설정

### 파일 구조

- `init.lua` - Hammerspoon 메인 설정 파일
- `input-source-switcher.lua` - 앱별 입력 소스 자동 전환 모듈

### 현재 기능

#### 자동 입력 소스 전환
- **Ghostty**: 앱에 포커스 시 자동으로 영어 입력 소스로 전환
- 포커스 해제 시 원래 입력 소스로 복원하지 않음 (단방향)

### 사용 방법

#### 다른 앱 추가하기

`init.lua` 파일의 `InputSourceSwitcher.config.apps`에 앱을 추가:

```lua
InputSourceSwitcher.config.apps = {
  ["Ghostty"] = "ENGLISH",
  ["Terminal"] = "ENGLISH",
  ["iTerm2"] = "ENGLISH",
  ["Messages"] = "com.apple.inputmethod.Korean"  -- 한글
}
```

#### 설정 리로드

Hammerspoon 메뉴에서 "Reload Config" 선택 또는 `⌘⌃R`

#### 현재 입력 소스 ID 확인

단축키: `Ctrl+Alt+Cmd+I`

또는 Hammerspoon 콘솔에서:
```lua
hs.keycodes.currentSourceID()
```

### 디버깅

Hammerspoon 콘솔에서 다음 명령어 사용:

```lua
-- 현재 입력 소스 확인
hs.keycodes.currentSourceID()

-- 감지된 영어 입력 소스 확인
InputSourceSwitcher.getEnglishSourceID()
```

### 커스터마이징

#### 영어 입력 소스 ID 수동 설정

`init.lua`에서:
```lua
InputSourceSwitcher.setEnglishSourceID("com.apple.keylayout.ABC")
```

#### 디버그 로깅 활성화

`init.lua`에서:
```lua
InputSourceSwitcher.config.debug = true
```

---

## 새 노트북 세팅

```bash
# 1. Dotfiles clone
mkdir -p ~/workspace/personal
git clone <your-repo-url> ~/workspace/personal/dotfiles

# 2. Install 스크립트 실행
cd ~/workspace/personal/dotfiles
./install.sh
```

install.sh는 자동으로:
- Homebrew 설치 (없으면)
- Brewfile로 패키지 설치
- ~/.hammerspoon 심볼릭 링크 생성

## 트러블슈팅

### Hammerspoon이 작동하지 않음

```bash
# 심볼릭 링크 확인
ls -la ~/.hammerspoon

# Hammerspoon 리로드
# Hammerspoon 메뉴 → Reload Config (⌘⌃R)
```

### 심볼릭 링크 재생성

```bash
rm ~/.hammerspoon
ln -s ~/workspace/personal/dotfiles/hammerspoon ~/.hammerspoon
```

### 백업 복원

기존 설정 백업이 있는 경우:
```bash
# 백업 위치
~/.hammerspoon.backup

# 복원
rm ~/.hammerspoon
mv ~/.hammerspoon.backup ~/.hammerspoon
```

## 확장 계획

향후 추가 예정:
- [ ] zsh 설정 (.zshrc)
- [ ] git 설정 (.gitconfig)
- [ ] vim 설정 (.vimrc)
- [ ] SSH 설정
- [ ] 머신별 설정 분리

## 참고

- **README.md**: 일반 사용자용 공개 문서
- **CLAUDE.md**: Claude Code용 상세 개발 가이드 (이 파일)
