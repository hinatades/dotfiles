local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font = wezterm.font("HackGen35 Console NF")
config.font_size = 18.0
config.use_ime = true
-- macOSのIMEキーバインド（Ctrl+K等）を有効にする
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
config.window_background_opacity = 0.85
config.macos_window_background_blur = 0

-- カーソル設定
config.default_cursor_style = "BlinkingUnderline"

-- macOS非ネイティブフルスクリーン（現在のワークスペースでメニューバーも隠す）
config.native_macos_fullscreen_mode = false

-- 起動時に自動でフルスクリーンにする
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mcp.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

-- フォーカス時にフルスクリーンでなければ自動で最大化（ディスプレイ切替対策）
wezterm.on("window-focus-changed", function(window, pane)
	if window:is_focused() then
		local overrides = window:get_config_overrides() or {}
		-- フルスクリーン状態でない場合のみ適用
		if not window:get_dimensions().is_full_screen then
			window:toggle_fullscreen()
		end
	end
end)

-- 閉じる確認ダイアログを無効化
config.window_close_confirmation = "NeverPrompt"

-- スクロールバック履歴の行数
config.scrollback_lines = 2000

-- スクロールバーを無効化（見切れ防止）
config.enable_scroll_bar = false

-- ウィンドウパディング（画面端からの余白、下部の見切れ防止）
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 2,
}

----------------------------------------------------
-- Tab
----------------------------------------------------
-- タイトルバーを非表示、ウィンドウ移動も無効化
config.window_decorations = "NONE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = true
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブバーの透過
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
	font = wezterm.font("HackGen35 Console NF"),
	font_size = 15.0,
}

-- タブバーを背景色に合わせる
config.window_background_gradient = {
	colors = { "#000000" },
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false

-- タブ同士の境界線を非表示
config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}

-- タブの形をカスタマイズ
-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background

	-- Get current working directory basename
	local cwd = tab.active_pane.current_working_dir
	local title = tab.active_pane.title
	if cwd then
		local cwd_uri = cwd
		-- Extract path from file:// URI
		local path = cwd_uri.file_path or cwd_uri.path or cwd_uri
		if path then
			-- Get basename of the path
			title = path:match("([^/]+)/?$") or path
		end
	end

	title = "   " .. wezterm.truncate_right(title, max_width - 1) .. "   "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

----------------------------------------------------
-- keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
local keybinds = require("keybinds")
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables
config.mouse_bindings = keybinds.mouse_bindings
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

return config
