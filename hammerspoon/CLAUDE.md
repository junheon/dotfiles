# Hammerspoon Configuration

Hammerspoon 자동화 설정 디렉토리

## 현재 기능

### 자동 입력 소스 전환
- **Ghostty**: 앱에 포커스 시 자동으로 영어 입력 소스로 전환

## 파일 구조

- `init.lua` - Hammerspoon 메인 설정 파일
- `input-source-switcher.lua` - 앱별 입력 소스 자동 전환 모듈
- `Spoons/` - Hammerspoon Spoons (확장 모듈) 디렉토리

## 사용 방법

### 다른 앱 추가하기

`init.lua` 파일의 `InputSourceSwitcher.config.apps`에 앱을 추가:

```lua
InputSourceSwitcher.config.apps = {
  ["Ghostty"] = "ENGLISH",
  ["Terminal"] = "ENGLISH",
  ["Messages"] = "com.apple.inputmethod.Korean"
}
```

### 설정 리로드

Hammerspoon 메뉴에서 "Reload Config" 선택 또는 `⌘⌃R`

## 디버깅

Hammerspoon 콘솔에서 다음 명령어 사용:

```lua
-- 현재 입력 소스 확인
hs.keycodes.currentSourceID()

-- 사용 가능한 모든 입력 소스 목록
hs.inspect(hs.keycodes.inputSources())

-- 감지된 영어 입력 소스 확인
InputSourceSwitcher.getEnglishSourceID()
```
