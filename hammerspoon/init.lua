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

-- ウィンドウがフルスクリーン相当かチェック（非ネイティブフルスクリーン対応）
local function isFullscreenSize(win)
  if not win then return false end
  local winFrame = win:frame()
  local screenFrame = win:screen():fullFrame()
  -- ウィンドウが画面全体を覆っているかチェック（数ピクセルの誤差を許容）
  return math.abs(winFrame.x - screenFrame.x) < 5
    and math.abs(winFrame.y - screenFrame.y) < 5
    and math.abs(winFrame.w - screenFrame.w) < 5
    and math.abs(winFrame.h - screenFrame.h) < 5
end

-- WezTermにCmd+Enterを送信してフルスクリーンにする
local function sendFullscreenKey(app)
  if not app then return end
  hs.eventtap.keyStroke({"cmd"}, "return", 0, app)
end

-- フルスクリーンでなければフルスクリーンにする
local function ensureFullscreen(app, tries)
  tries = tries or 15
  local win = getTerminalWindow(app)
  if win then
    if not isFullscreenSize(win) then
      sendFullscreenKey(app)
    end
    return
  end
  if tries <= 0 then return end
  hs.timer.doAfter(0.05, function()
    ensureFullscreen(app, tries - 1)
  end)
end

-- Terminal toggle (Ctrl+Return)
hs.hotkey.bind({ "ctrl" }, "return", function()
  local app = hs.application.find(APP_NAME)

  -- アプリが起動していない場合は起動
  if not app then
    hs.application.launchOrFocus(APP_NAME)
    -- WezTermのgui-startupでフルスクリーンになるので追加処理は不要
    return
  end

  -- 前面に見えているなら「非表示」
  if app:isFrontmost() then
    app:hide()
    return
  end

  -- 起動しているが非表示 → 表示
  app:activate()

  -- メインディスプレイに移動してからフルスクリーンにする
  hs.timer.doAfter(0.1, function()
    local a = hs.application.find(APP_NAME)
    if a then
      local win = getTerminalWindow(a)
      if win then
        local primaryScreen = hs.screen.primaryScreen()
        -- 現在のスクリーンがメインでない場合のみ移動
        if win:screen() ~= primaryScreen then
          win:moveToScreen(primaryScreen)
        end
      end
      ensureFullscreen(a)
    end
  end)
end)

-- Window Management (Cmd+Shift+h/j/k/l)

-- h: 横幅を1/2して左に配置
hs.hotkey.bind({"cmd", "shift"}, "h", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  -- WezTermの場合は何もしない
  if win:application():name() == APP_NAME then return end
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
  -- WezTermの場合は何もしない
  if win:application():name() == APP_NAME then return end
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
  -- WezTermの場合は何もしない
  if win:application():name() == APP_NAME then return end
  win:maximize()
end)

-- k: 中央に配置
hs.hotkey.bind({"cmd", "shift"}, "k", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  -- WezTermの場合は何もしない
  if win:application():name() == APP_NAME then return end
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
