-- Terminal app to toggle with Ctrl+Return
local APP_NAME = "WezTerm"

-- Terminal toggle (Ctrl+Return)
hs.hotkey.bind({ "ctrl" }, "return", function()
  local app = hs.application.find(APP_NAME)

  -- アプリが起動していない場合は起動（WezTermの設定で自動フルスクリーン）
  if not app then
    hs.application.launchOrFocus(APP_NAME)
    return
  end

  -- 前面に見えているなら非表示
  if app:isFrontmost() then
    app:hide()
    return
  end

  -- 起動しているが非表示 → 表示
  app:activate()
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
