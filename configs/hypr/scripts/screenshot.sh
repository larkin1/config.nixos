#!/usr/bin/env bash
# usage: screenshot.sh <scrim RRGGBB> <outline RRGGBB>
set -euo pipefail

scrim="#${1}52"
outline="#${2}ff"
dir="$HOME"
tmp=$(mktemp --suffix .png)
trap 'rm -f "$tmp"' EXIT

# only windows on workspaces that are actually shown (normal + open special, per monitor)
rects=$(jq -rn --argjson m "$(hyprctl -j monitors)" --argjson c "$(hyprctl -j clients)" '
  [$m[] | .activeWorkspace.id, .specialWorkspace.id] as $ws
  | $c[]
  | select(.mapped and (.hidden | not))
  | select(.workspace.id as $id | $ws | any(. == $id))
  | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')

geom=$(slurp -o -b "$scrim" -B "$scrim" -c "$outline" <<<"$rects") || exit 0
grim -g "$geom" "$tmp"
wl-copy -t image/png <"$tmp"

action=$(dunstify "Screenshot taken" "Click to edit" -i "$tmp" -t 10000 --action="default,Edit")
[[ $action == default ]] || exit 0

mkdir -p "$dir"
satty --filename "$tmp" --copy-command wl-copy \
  --output-filename "$dir/img-$(date +%F_%H-%M-%S).png"
