#!/bin/sh
# Claude Code の状態を WezTerm の pane 単位 user var (agent_state) に書き込む。
# WezTerm 側は wezterm/agent_status.lua が読み取ってタブ/ステータスバーに表示する。
#
# Usage: wezterm-agent-state.sh <working|blocked|done|clear>

[ -n "$WEZTERM_PANE" ] || exit 0

state=$1
[ "$state" = "clear" ] && state=""

# 制御端末が無い場合（CI 等）は何もしない。2>/dev/null を先に置いてオープン失敗も黙らせる
printf '\033]1337;SetUserVar=agent_state=%s\007' \
	"$(printf '%s' "$state" | base64)" 2>/dev/null >/dev/tty

exit 0
