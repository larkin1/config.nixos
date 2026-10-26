#!/bin/sh

mode="${1:-dark}"

prefer=false; [ "$mode" = dark ] && prefer=true
printf '[Settings]\ngtk-theme-name=adw-gtk3\ngtk-application-prefer-dark-theme=%s\n' "$prefer" \
  > "$HOME/.config/gtk-3.0/settings.ini"

case "$mode" in
  dark)  target="adw-gtk3-dark"; ;;
  light) target="adw-gtk3";      ;;
  *) echo "gtk-themes-reload.sh: unknown mode '$1'" >&2; exit 0 ;;
esac

gsettings set org.gnome.desktop.interface gtk-theme "$target"

case "$mode" in
  dark)  gsettings set org.gnome.desktop.interface color-scheme prefer-dark    ;;
  light) gsettings set org.gnome.desktop.interface color-scheme prefer-default ;;
esac
