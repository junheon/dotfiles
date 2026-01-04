# Dotfiles

개인 macOS 개발 환경 설정

## 구조

```
~/workspace/personal/dotfiles/  (원본 - git repo)
├── hammerspoon/               # Hammerspoon 설정
│   ├── init.lua
│   ├── input-source-switcher.lua
│   └── CLAUDE.md
├── config/                    # ~/.config 심볼릭 링크 대상
│   ├── nvim/                 # Neovim (LazyVim)
│   ├── zed/                  # Zed editor
│   ├── ghostty/              # Modern terminal
│   ├── fish/                 # Fish shell
│   ├── git/                  # Git 전역 설정
│   ├── alacritty/            # Terminal
│   ├── kitty/                # Terminal
│   ├── zellij/               # Terminal multiplexer
│   ├── iterm2/               # macOS terminal
│   ├── doom/                 # Doom Emacs
│   ├── emacs/                # GNU Emacs
│   ├── opencode/             # OpenCode editor
│   ├── raycast/              # Productivity tool
│   ├── broot/                # File browser
│   ├── gh/                   # GitHub CLI
│   ├── gh-dash/              # GitHub dashboard
│   ├── containers/           # Podman containers
│   └── waveterm/             # Terminal
├── Brewfile                   # Homebrew 패키지 목록
├── scripts/
│   └── auto-sync.sh          # 자동 동기화 스크립트
├── install.sh                 # 자동 설치 스크립트
├── .gitignore
└── README.md

~/.hammerspoon → ~/workspace/personal/dotfiles/hammerspoon/
~/.config → ~/workspace/personal/dotfiles/config/ (심볼릭 링크)
```

## 기능

### ~/.config 설정

개발 도구 설정 파일들을 중앙에서 관리합니다. 모든 `~/.config/*` 디렉토리는 `~/workspace/personal/dotfiles/config/`로의 심볼릭 링크입니다.

#### 에디터/IDE

**nvim/** - Neovim 설정 (LazyVim distribution)
- 키맵, 플러그인, 옵션 설정
- Lua 기반 설정

**zed/** - Zed editor
- vim_mode, 테마, 폰트 사이즈 설정

**doom/** - Doom Emacs configuration
- Emacs 설정 프레임워크
- 모듈화된 설정 구조

**emacs/** - GNU Emacs
- Doom Emacs 배포판

**opencode/** - OpenCode editor
- 에디터 설정

#### 터미널 에뮬레이터

**ghostty/** - Modern terminal emulator
- 터미널 테마, 키바인딩, 폰트 설정
- GPU 가속

**alacritty/** - GPU-accelerated terminal
- 터미널 색상, 폰트 설정

**kitty/** - GPU-accelerated terminal
- 터미널 설정

**iterm2/** - macOS专用 terminal
- 프로필, 색상, 키 설정

**waveterm/** - Terminal emulator
- 터미널 세션, 프리셋

#### 터미널 도구

**zellij/** - Terminal multiplexer
- 키바인딩, 플러그인 설정
- tmux 대안

**fish/** - Fish shell
- 쉘 환경 변수, 함수, aliases
- 자동완성 설정

#### 버전 관리

**git/** - Git 전역 설정
- 전역 gitignore
- Git 별칭, 설정

#### CLI 도구

**broot/** - File browser & tree search
- 파일 탐색 커스터마이징
- verb, skin 설정

**gh/** - GitHub CLI
- git_protocol, editor, aliases
- hosts.yml은 .gitignore로 제외됨

**gh-dash/** - GitHub CLI dashboard
- PR/Issues 대시보드 설정
- 섹션, 필터, 레이아웃

**containers/** - Podman containers
- 컨테이너 설정

#### 프로덕티비티

**raycast/** - macOS productivity tool
- 단축키, 스크립트, 확장

### Hammerspoon
- **자동 입력 소스 전환**: Ghostty 앱에 포커스 시 자동으로 영어 입력 소스로 전환

### Homebrew
- Brewfile로 설치된 모든 패키지 관리
- 새 노트북에서 한 번에 환경 복원 가능

### 자동 동기화

로컬 설정 변경사항을 자동으로 GitHub에 동기화합니다.

**기능:**
- **30분마다 자동 실행**: launchd를 통해 주기적으로 실행
- **macOS 알림**: 변경사항 발생 시 알림 표시
- **자동 충돌 해결**: git pull --rebase로 자동 병합
- **자동 커밋 & 푸시**: 변경사항을 자동으로 커밋하고 GitHub에 푸시

**실행 방법:**

서비스 시작 (재부팅 후 자동 시작):
```bash
# launchd 서비스 등록
launchctl load ~/Library/LaunchAgents/com.user.dotfiles-sync.plist

# 동작 확인
launchctl list | grep dotfiles
```

서비스 중지:
```bash
launchctl unload ~/Library/LaunchAgents/com.user.dotfiles-sync.plist
```

수동 실행:
```bash
~/workspace/personal/dotfiles/scripts/auto-sync.sh
```

로그 확인:
```bash
# 전체 로그
tail -f ~/Library/Logs/dotfiles-sync/sync.log

# 출력 로그
cat ~/Library/Logs/dotfiles-sync/output.log

# 에러 로그
cat ~/Library/Logs/dotfiles-sync/error.log
```

**주기 변경:**

`~/Library/LaunchAgents/com.user.dotfiles-sync.plist`의 `StartInterval` 값 수정 (단위: 초)
- 5분: 300
- 30분: 1800 (현재)
- 1시간: 3600

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

## 사용법

### Hammerspoon 설정 변경
```bash
# 심볼릭 링크를 통해 직접 편집 가능
vim ~/.hammerspoon/init.lua

# 또는 원본 직접 편집
cd ~/workspace/personal/dotfiles/hammerspoon
vim init.lua

# 변경 후 커밋
git add .
git commit -m "Update hammerspoon config"
git push
```

### Hammerspoon에 앱 추가
`init.lua`의 `InputSourceSwitcher.config.apps`에 앱 추가:

```lua
InputSourceSwitcher.config.apps = {
  ["Ghostty"] = "ENGLISH",
  ["Terminal"] = "ENGLISH",
  ["iTerm2"] = "ENGLISH"
}
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

## 다른 설정 추가하기

### 1. 설정 파일 추가
```bash
cd ~/workspace/personal/dotfiles
mkdir zsh
cp ~/.zshrc zsh/
```

### 2. 심볼릭 링크 생성
```bash
rm ~/.zshrc
ln -s ~/workspace/personal/dotfiles/zsh/.zshrc ~/.zshrc
```

### 3. install.sh 업데이트
`install.sh`에 심볼릭 링크 생성 코드 추가

### 4. 커밋
```bash
git add .
git commit -m "Add zsh config"
git push
```

## 트러블슈팅

### Hammerspoon이 작동하지 않음
```bash
# 심볼릭 링크 확인
ls -la ~/.hammerspoon

# Hammerspoon 리로드
# Hammerspoon 메뉴 → Reload Config (⌘⌃R)
```

### 현재 입력 소스 ID 확인
Hammerspoon 콘솔에서:
```lua
hs.keycodes.currentSourceID()
```

또는 단축키 `Ctrl+Alt+Cmd+I`로 확인

## 백업 복원

기존 설정 백업이 있는 경우:
```bash
# 백업 위치
~/.hammerspoon.backup
```

## 라이센스

개인 사용
