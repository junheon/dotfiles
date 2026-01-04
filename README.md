# Dotfiles

개인 macOS 개발 환경 설정

## 구조

```
~/workspace/personal/dotfiles/  (원본 - git repo)
├── hammerspoon/               # Hammerspoon 설정
│   ├── init.lua
│   ├── input-source-switcher.lua
│   └── CLAUDE.md
├── Brewfile                   # Homebrew 패키지 목록
├── install.sh                 # 자동 설치 스크립트
├── .gitignore
└── README.md

~/.hammerspoon → ~/workspace/personal/dotfiles/hammerspoon/ (심볼릭 링크)
```

## 기능

### Hammerspoon
- **자동 입력 소스 전환**: Ghostty 앱에 포커스 시 자동으로 영어 입력 소스로 전환

### Homebrew
- Brewfile로 설치된 모든 패키지 관리
- 새 노트북에서 한 번에 환경 복원 가능

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
