-- Claude Code のエージェント状態をタブとステータスバーに集約表示する。
-- 状態は claude/hooks/wezterm-agent-state.sh が OSC 1337 で pane の user var に書き込む。
local wezterm = require("wezterm")

local M = {}

-- 表示順 = 優先度（上ほど強い）
local ORDER = { "blocked", "working", "done" }

M.states = {
	blocked = { icon = "◉", color = "#d75f5f" },
	working = { icon = "◐", color = "#ae8b2d" },
	done = { icon = "✔", color = "#5faf5f" },
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

function M.setup()
	wezterm.on("update-status", function(window, _pane)
		local counts = count_all()
		local items = {}
		for _, name in ipairs(ORDER) do
			if counts[name] > 0 then
				table.insert(items, { Foreground = { Color = M.states[name].color } })
				table.insert(items, { Text = M.states[name].icon .. " " .. counts[name] .. "  " })
			end
		end
		window:set_right_status(wezterm.format(items))
	end)
end

return M
