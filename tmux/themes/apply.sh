#!/usr/bin/env bash
# 统一主题入口：重置主题相关选项 → 加载 themes/<name>.conf → 记录选择
#
# 用法:
#   apply.sh                 恢复上次使用的主题（没有记录则用默认主题）
#   apply.sh catppuccin-latte 应用指定主题
#
# 每个主题就是 themes/ 下的一个 .conf 文件：
#   - 自定义主题：直接写 tmux set 命令
#   - 插件主题：set 插件变量 + run-shell 执行插件脚本

set -uo pipefail

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/tmux"
STATE_FILE="$STATE_DIR/theme"
DEFAULT_THEME="catppuccin-macchiato"

theme="${1:-}"
if [ -z "$theme" ]; then
	theme="$(cat "$STATE_FILE" 2>/dev/null || true)"
	[ -z "$theme" ] && theme="$DEFAULT_THEME"
fi

if [ ! -f "$DIR/$theme.conf" ]; then
	tmux display-message "theme not found: $theme"
	exit 1
fi

# 主题可能改到的选项。先恢复默认值，避免从上一套主题残留配色。
# global / window / session 三个作用域都清一遍，清不掉的（选项不属于该作用域）忽略。
while IFS= read -r opt; do
	[ -n "$opt" ] || continue
	tmux set -gu "$opt" 2>/dev/null || true
	tmux set -wu "$opt" 2>/dev/null || true
	tmux set -u "$opt" 2>/dev/null || true
done <<'EOF'
status
status-style
status-left
status-left-length
status-left-style
status-right
status-right-length
status-right-style
status-justify
status-position
window-status-style
window-status-current-style
window-status-last-style
window-status-format
window-status-current-format
window-status-separator
window-status-activity-style
window-status-bell-style
pane-border-style
pane-active-border-style
pane-border-status
message-style
message-command-style
mode-style
clock-mode-colour
clock-mode-style
display-panes-colour
display-panes-active-colour
menu-style
menu-selected-style
menu-border-style
menu-border-lines
EOF

tmux source-file "$DIR/$theme.conf"
tmux set -g @theme "$theme"

mkdir -p "$STATE_DIR"
printf '%s\n' "$theme" >"$STATE_FILE"

tmux display-message "Theme: $theme"
