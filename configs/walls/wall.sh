#! /usr/bin/env bash

WPATH="$1"
AUTOMODE="${2:-}"

export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
if [[ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" && -d "$XDG_RUNTIME_DIR/hypr" ]]; then
  HYPRLAND_INSTANCE_SIGNATURE="$(find "$XDG_RUNTIME_DIR/hypr" | head -n1)"
  export HYPRLAND_INSTANCE_SIGNATURE
fi

hyprctl hyprpaper wallpaper ",$WPATH," || true

case $AUTOMODE in
"") matugen image "$WPATH" --config "$HOME/.config/matugen/matugen.toml" ;;
*) matugen image "$WPATH" --config "$HOME/.config/matugen/matugen.toml" --type="$AUTOMODE" --source-color-index=0 ;;
esac
