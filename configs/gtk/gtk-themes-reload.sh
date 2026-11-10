#!/bin/sh

mode="${1:-dark}"

case "$mode" in
dark)
  target="adw-gtk3-matugen-dark"
  prefer=true
  ;;
light)
  target="adw-gtk3-matugen"
  prefer=false
  ;;
*)
  echo "gtk-themes-reload.sh: unknown mode '$1'" >&2
  exit 0
  ;;
esac

printf '[Settings]\ngtk-theme-name=%s\ngtk-application-prefer-dark-theme=%s\n' "$target" "$prefer" \
  >"$HOME/.config/gtk-3.0/settings.ini"

gsettings set org.gnome.desktop.interface gtk-theme Adwaita
gsettings set org.gnome.desktop.interface gtk-theme "$target"

case "$mode" in
dark) gsettings set org.gnome.desktop.interface color-scheme prefer-dark ;;
light) gsettings set org.gnome.desktop.interface color-scheme prefer-default ;;
esac
