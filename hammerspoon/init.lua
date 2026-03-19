-- Terminal app to toggle with Ctrl+Return
local APP_NAME = "WezTerm"

-- ターミナルのウィンドウを取得
local function getTerminalWindow(app)
  if not app then return nil end
  local wins = app:allWindows()
  if wins and #wins > 0 then
    return wins[1]
  end
  return nil
end

-- 外部ディスプレイがあればそれを、なければ内蔵ディスプレイを返す
local function getMainScreen()
  for _, s in ipairs(hs.screen.allScreens()) do
    if s ~= hs.screen.find("Built%-in") then
      return s
    end
  end
  return hs.screen.primaryScreen()
end

-- ウィンドウをメインディスプレイにフルスクリーン配置
local function moveToMainFullscreen(win)
  if not win then return end
  win:setFrame(getMainScreen():fullFrame())
end

-- ウィンドウが出現するのを待ってからフルスクリーン配置
local function waitAndFullscreen(tries)
  tries = tries or 20
  local app = hs.application.find(APP_NAME)
  local win = getTerminalWindow(app)
  if win then
    moveToMainFullscreen(win)
    return
  end
  if tries <= 0 then return end
  hs.timer.doAfter(0.1, function()
    waitAndFullscreen(tries - 1)
  end)
end

-- Terminal toggle (Ctrl+Return)
hs.hotkey.bind({ "ctrl" }, "return", function()
  local app = hs.application.find(APP_NAME)

  -- アプリが起動していない場合は起動してフルスクリーン配置
  if not app then
    hs.application.launchOrFocus(APP_NAME)
    waitAndFullscreen()
    return
  end

  -- 前面に見えているなら「非表示」
  if app:isFrontmost() then
    app:hide()
    return
  end

  -- 起動しているが非表示 → メインディスプレイに表示
  app:activate()
  hs.timer.doAfter(0.15, function()
    local a = hs.application.find(APP_NAME)
    if not a then return end
    moveToMainFullscreen(getTerminalWindow(a))
  end)
end)

-- Window Management (Cmd+Shift+h/j/k/l)

-- h: 横幅を1/2して左に配置
hs.hotkey.bind({"cmd", "shift"}, "h", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  if win:application():name() == APP_NAME then return end
  local max = win:screen():frame()
  win:setFrame({ x = max.x, y = max.y, w = max.w / 2, h = max.h })
end)

-- l: 横幅を1/2して右に配置
hs.hotkey.bind({"cmd", "shift"}, "l", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  if win:application():name() == APP_NAME then return end
  local max = win:screen():frame()
  win:setFrame({ x = max.x + max.w / 2, y = max.y, w = max.w / 2, h = max.h })
end)

-- j: 最大化
hs.hotkey.bind({"cmd", "shift"}, "j", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  if win:application():name() == APP_NAME then return end
  win:maximize()
end)

-- k: 中央に配置
hs.hotkey.bind({"cmd", "shift"}, "k", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  if win:application():name() == APP_NAME then return end
  local max = win:screen():frame()
  local w = max.w * 0.8
  local h = max.h * 0.8
  win:setFrame({ x = max.x + (max.w - w) / 2, y = max.y + (max.h - h) / 2, w = w, h = h })
end)

-- 設定の再読み込み
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
