local APP_NAME = "WezTerm"

-- 今いる画面（マウス基準）
local function currentScreen()
  return hs.mouse.getCurrentScreen() or hs.screen.mainScreen()
end

-- WezTerm のウィンドウを確実に取得
local function getWezTermWindow(app)
  if not app then return nil end
  local wins = app:allWindows()
  if wins and #wins > 0 then
    return wins[1]
  end
  return nil
end

-- 同一 Space のまま最大化（メニューバー領域も含む）
local function maximize(win)
  if not win then return end
  local screen = currentScreen()
  win:moveToScreen(screen)
  -- fullFrame() を使うとメニューバー領域も含めた画面全体を使用
  win:setFrame(screen:fullFrame(), 0)
end

-- 起動直後対策（ウィンドウが出るまで待つ）
local function ensureMaximized(app, tries)
  tries = tries or 15
  local win = getWezTermWindow(app)
  if win then
    maximize(win)
    return
  end
  if tries <= 0 then return end
  hs.timer.doAfter(0.05, function()
    ensureMaximized(app, tries - 1)
  end)
end

-- WezTerm toggle
hs.hotkey.bind({ "ctrl" }, "return", function()
  local app = hs.application.find(APP_NAME)

  -- アプリが起動していない場合は何もしない
  if not app then
    return
  end

  -- 前面に見えているなら「非表示」
  if app:isFrontmost() then
    app:hide()
    return
  end

  -- 起動しているが非表示 → 表示
  app:activate()

  -- 表示後に必ず最大化
  hs.timer.doAfter(0.05, function()
    local a = hs.application.find(APP_NAME)
    if a then ensureMaximized(a) end
  end)
end)

-- Window Management (Cmd+Shift+h/j/k/l)

-- h: 横幅を1/2して左に配置
hs.hotkey.bind({"cmd", "shift"}, "h", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- l: 横幅を1/2して右に配置
hs.hotkey.bind({"cmd", "shift"}, "l", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- j: 最大化
hs.hotkey.bind({"cmd", "shift"}, "j", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  win:maximize()
end)

-- k: 中央に配置
hs.hotkey.bind({"cmd", "shift"}, "k", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = max.w * 0.8
  f.h = max.h * 0.8
  f.x = max.x + (max.w - f.w) / 2
  f.y = max.y + (max.h - f.h) / 2
  win:setFrame(f)
end)

-- 設定の再読み込み
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
