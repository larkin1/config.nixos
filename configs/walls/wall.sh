#! /usr/bin/env bash

WPATH="$1"

hyprctl hyprpaper wallpaper ",$WPATH,"
matugen image "$WPATH" --config "$HOME/.config/matugen/matugen.toml"
