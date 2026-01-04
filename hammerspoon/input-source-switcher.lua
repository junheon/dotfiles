-- Input Source Switcher Module
-- Automatically switches input sources when specific apps get focus

local M = {}

-- Configuration
M.config = {
  apps = {},              -- Map of app names to input source IDs
  englishSourceID = nil,  -- Override detected English source ID
  debug = false          -- Enable debug logging
}

-- Private variables
local logger = hs.logger.new('InputSourceSwitcher', 'info')
local watcher = nil
local detectedEnglishID = nil

-- Get English input source ID
-- Uses default "com.apple.keylayout.ABC" if not manually configured
local function getEnglishInputSource()
  -- Return manually configured ID if available
  if M.config.englishSourceID then
    return M.config.englishSourceID
  end

  -- Use default ABC layout (most common US English)
  local defaultID = "com.apple.keylayout.ABC"
  logger.i("Using default English input source: " .. defaultID)
  return defaultID
end

-- Switch to specified input source
local function switchToInputSource(sourceID)
  if not sourceID then
    logger.e("Invalid source ID: nil")
    return false
  end

  -- Check if already on the target source
  local currentSource = hs.keycodes.currentSourceID()
  if currentSource == sourceID then
    if M.config.debug then
      logger.d("Already on target input source: " .. sourceID)
    end
    return true
  end

  -- Attempt to switch
  local success, result = pcall(function()
    hs.keycodes.currentSourceID(sourceID)
  end)

  if success then
    if M.config.debug then
      logger.i("Switched input source to: " .. sourceID)
    end
    return true
  else
    logger.e("Failed to switch input source: " .. tostring(result))
    return false
  end
end

-- Handle application events
local function handleAppEvent(appName, eventType, appObject)
  -- Only handle activation events
  if eventType ~= hs.application.watcher.activated then
    return
  end

  if M.config.debug then
    logger.d("App activated: " .. appName)
  end

  -- Check if this app has a configured input source
  local targetSource = M.config.apps[appName]
  if not targetSource then
    return
  end

  -- Resolve "ENGLISH" marker to detected English source
  if targetSource == "ENGLISH" then
    targetSource = detectedEnglishID or M.config.englishSourceID
    if not targetSource then
      logger.e("English input source not detected and not manually configured")
      return
    end
  end

  -- Switch to target input source
  switchToInputSource(targetSource)
end

-- Public API: Start the watcher
function M.start()
  -- Get English input source ID (default or manually configured)
  if not detectedEnglishID then
    detectedEnglishID = getEnglishInputSource()
  end

  -- Stop existing watcher if any
  if watcher then
    watcher:stop()
  end

  -- Create and start new watcher
  local success, result = pcall(function()
    watcher = hs.application.watcher.new(handleAppEvent)
    watcher:start()
  end)

  if success then
    logger.i("InputSourceSwitcher started successfully")
    logger.i("English source ID: " .. (detectedEnglishID or "none"))

    -- Count and list configured apps
    local appNames = {}
    for name, _ in pairs(M.config.apps) do
      table.insert(appNames, name)
    end
    if #appNames > 0 then
      logger.i("Watching apps: " .. table.concat(appNames, ", "))
    else
      logger.i("No apps configured")
    end

    return true
  else
    logger.e("Failed to start watcher: " .. tostring(result))
    return false
  end
end

-- Public API: Stop the watcher
function M.stop()
  if watcher then
    watcher:stop()
    watcher = nil
    logger.i("InputSourceSwitcher stopped")
    return true
  end
  return false
end

-- Public API: Add an app to watch list
function M.addApp(appName, sourceID)
  if type(appName) ~= "string" or appName == "" then
    logger.e("Invalid app name")
    return false
  end

  if type(sourceID) ~= "string" or sourceID == "" then
    logger.e("Invalid source ID")
    return false
  end

  M.config.apps[appName] = sourceID
  logger.i("Added app: " .. appName .. " -> " .. sourceID)
  return true
end

-- Public API: Remove an app from watch list
function M.removeApp(appName)
  if M.config.apps[appName] then
    M.config.apps[appName] = nil
    logger.i("Removed app: " .. appName)
    return true
  end
  return false
end

-- Public API: Set English source ID manually
function M.setEnglishSourceID(sourceID)
  if type(sourceID) ~= "string" or sourceID == "" then
    logger.e("Invalid source ID")
    return false
  end

  M.config.englishSourceID = sourceID
  detectedEnglishID = sourceID
  logger.i("English source ID set to: " .. sourceID)
  return true
end

-- Public API: Get detected English source ID
function M.getEnglishSourceID()
  return detectedEnglishID or M.config.englishSourceID
end

return M
