-- Claude Code のエージェント状態をタブとステータスバーに集約表示する。
-- 状態は claude/hooks/wezterm-agent-state.sh が OSC 1337 で pane の user var に書き込む。
local wezterm = require("wezterm")

local M = {}

-- 表示順 = 優先度（上ほど強い）
local ORDER = { "blocked", "working", "done" }

-- 色は暗い無彩色のタブ背景の上で識別できる明度に寄せてある
M.states = {
	blocked = { icon = "◉", color = "#ff7b72" },
	working = { icon = "◐", color = "#e3b341" },
	done = { icon = "✔", color = "#3fb950" },
}

local rank = {}
for i, name in ipairs(ORDER) do
	rank[name] = #ORDER - i
end

-- タブ内のペインで最も優先度の高い状態を返す（なければ nil）
function M.tab_state(tab)
	local best
	for _, pane in ipairs(tab.panes) do
		local state = pane.user_vars and pane.user_vars.agent_state
		if state and rank[state] and (best == nil or rank[state] > rank[best]) then
			best = state
		end
	end
	return best
end

local function count_all()
	local counts = { blocked = 0, working = 0, done = 0 }
	for _, window in ipairs(wezterm.mux.all_windows()) do
		for _, tab in ipairs(window:tabs()) do
			for _, pane in ipairs(tab:panes()) do
				local state = pane:get_user_vars().agent_state
				if counts[state] then
					counts[state] = counts[state] + 1
				end
			end
		end
	end
	return counts
end

-- 全ウィンドウ横断の件数を1行にまとめる（該当なしなら nil）。
-- ステータスバーへの描画は keybinds.lua の update-right-status に集約しているため、
-- ここでは文字列を返すだけにしてハンドラを二重登録しない。
function M.summary()
	local counts = count_all()
	local parts = {}
	for _, name in ipairs(ORDER) do
		if counts[name] > 0 then
			table.insert(parts, M.states[name].icon .. " " .. counts[name])
		end
	end
	if #parts == 0 then
		return nil
	end
	return table.concat(parts, " ")
end

return M
