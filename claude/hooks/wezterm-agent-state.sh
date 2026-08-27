#!/bin/sh
# Claude Code の状態を WezTerm の pane 単位 user var (agent_state) に書き込む。
# WezTerm 側は wezterm/agent_status.lua が読み取ってタブ/ステータスバーに表示する。
#
# Usage: wezterm-agent-state.sh <working|blocked|done|clear>

[ -n "$WEZTERM_PANE" ] || exit 0

state=$1
[ "$state" = "clear" ] && state=""

payload=$(printf '%s' "$state" | base64)

emit() {
	printf '\033]1337;SetUserVar=agent_state=%s\007' "$payload"
}

# hook は制御端末を持たない子プロセスとして起動されるため /dev/tty が開けないことがある。
# その場合は親プロセスを遡って claude 本体の tty（= WezTerm の pane pty）を探して書き込む。
resolve_tty() {
	pid=$$
	depth=0
	while [ "$pid" -gt 1 ] && [ "$depth" -lt 10 ]; do
		name=$(ps -o tty= -p "$pid" 2>/dev/null | tr -d ' ')
		case "$name" in
		'' | '??' | '-') ;;
		*)
			printf '/dev/%s' "$name"
			return 0
			;;
		esac
		pid=$(ps -o ppid= -p "$pid" 2>/dev/null | tr -d ' ')
		[ -n "$pid" ] || return 1
		depth=$((depth + 1))
	done
	return 1
}

if : 2>/dev/null >/dev/tty; then
	emit >/dev/tty
else
	target=$(resolve_tty) && [ -w "$target" ] && emit >"$target"
fi

exit 0
