local wezterm = require("wezterm")
local agent_status = require("agent_status")
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

-- ベル音を無効化
config.audible_bell = "Disabled"

-- ウィンドウ配置はHammerspoonで管理するためWezTerm側のフルスクリーンは使わない
config.native_macos_fullscreen_mode = false

-- 閉じる確認ダイアログを無効化
config.window_close_confirmation = "NeverPrompt"

-- スクロールバック履歴の行数
config.scrollback_lines = 2000

-- スクロールバーを無効化（見切れ防止）
config.enable_scroll_bar = false

-- ウィンドウパディング（画面端からの余白、見切れ防止）
config.window_padding = {
	left = 2,
	right = 2,
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

-- タブの見た目
-- 状態インジケータ（赤/黄/緑）が沈まないよう、タブ自体は無彩色に寄せた濃淡だけで
-- アクティブ/非アクティブを表す。装飾記号は使わず、余白で区切った矩形にする。
local TAB_ACTIVE_BACKGROUND = "#39454e"
local TAB_ACTIVE_FOREGROUND = "#ffffff"
local TAB_INACTIVE_BACKGROUND = "#20272c"
local TAB_INACTIVE_FOREGROUND = "#8b9aa4"

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = TAB_INACTIVE_BACKGROUND
	local foreground = TAB_INACTIVE_FOREGROUND
	if tab.is_active then
		background = TAB_ACTIVE_BACKGROUND
		foreground = TAB_ACTIVE_FOREGROUND
	end

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
	title = wezterm.truncate_right(title, max_width - 6)

	local cells = {
		-- タブ同士の間の余白（タブバーの地の色を見せる）
		{ Background = { Color = "none" } },
		{ Text = " " },
		{ Background = { Color = background } },
	}

	-- エージェント状態のインジケータ（該当ペインがあるタブのみ）
	local state = agent_status.tab_state(tab)
	if state then
		table.insert(cells, { Foreground = { Color = agent_status.states[state].color } })
		table.insert(cells, { Text = " " .. agent_status.states[state].icon })
	end

	table.insert(cells, { Foreground = { Color = foreground } })
	table.insert(cells, { Text = "  " .. title .. "  " })
	table.insert(cells, { Background = { Color = "none" } })
	table.insert(cells, { Text = " " })

	return cells
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
