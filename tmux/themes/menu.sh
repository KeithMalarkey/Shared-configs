#!/usr/bin/env bash
# prefix+T：弹出 tmux 原生菜单，列出 themes/*.conf，选中后立即应用

set -uo pipefail

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
current="$(tmux show-options -gqv @theme 2>/dev/null || true)"
[ -z "$current" ] && current="none"

keys="123456789abcdefghijklmnopqrstuvwxyz"
args=()
i=0

for f in "$DIR"/*.conf; do
	[ -e "$f" ] || continue
	name="$(basename "$f" .conf)"
	label="$name"
	[ "$name" = "$current" ] && label="* $name"

	key="${keys:$i:1}"
	[ -z "$key" ] && key=""
	args+=("$label" "$key" "run-shell '$DIR/apply.sh $name'")
	i=$((i + 1))
done

tmux display-menu -T "Theme (current: $current)" "${args[@]}"
