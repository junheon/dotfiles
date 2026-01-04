-- Hammerspoon Configuration
-- Auto-reload config when files change

-- Load Input Source Switcher module
local InputSourceSwitcher = require("input-source-switcher")

-- Configure apps and their target input sources
InputSourceSwitcher.config.apps = {
  ["Ghostty"] = "ENGLISH"  -- Switch to English when Ghostty gets focus
}

-- Optional: Enable debug logging
-- InputSourceSwitcher.config.debug = true

-- Optional: Manually set English input source ID
-- InputSourceSwitcher.setEnglishSourceID("com.apple.keylayout.ABC")

-- Start the input source watcher
InputSourceSwitcher.start()

-- Helper: Show current input source ID (Ctrl+Alt+Cmd+I)
-- Useful for finding the correct input source IDs to configure
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "I", function()
  local currentID = hs.keycodes.currentSourceID()
  hs.alert.show("Current Input Source:\n" .. currentID, 3)
  print("Current Input Source ID: " .. currentID)
end)

-- Show notification when config is loaded
hs.alert.show("Hammerspoon config loaded")
