#!/bin/sh
# matugen post-hook — signals live GTK listeners (Chromium/Helium) after a palette change.
# dconf emits no signal for no-change writes, so if dconf already holds the target,
# step through the OTHER real variant name first. Never toggle through "": an empty
# theme name is what makes Chromium fall back to its built-in default palette.
# Usage: gtk-themes-reload.sh dark|light  (called with {{mode}})

mode="${1:-dark}"

prefer=false; [ "$mode" = dark ] && prefer=true
printf '[Settings]\ngtk-theme-name=adw-gtk3\ngtk-application-prefer-dark-theme=%s\n' "$prefer" \
  > "$HOME/.config/gtk-3.0/settings.ini"

case "$mode" in
  dark)  target="adw-gtk3-dark"; other="adw-gtk3"      ;;
  light) target="adw-gtk3";      other="adw-gtk3-dark" ;;
  *) echo "gtk-themes-reload.sh: unknown mode '$1'" >&2; exit 0 ;;
esac

cur="$(gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null | tr -d "'")"
if [ "$cur" = "$target" ]; then
  gsettings set org.gnome.desktop.interface gtk-theme "$other"   # force a real change
fi
gsettings set org.gnome.desktop.interface gtk-theme "$target"

# color-scheme drives the portal (web content, libadwaita); silent no-change write is fine here
case "$mode" in
  dark)  gsettings set org.gnome.desktop.interface color-scheme prefer-dark    ;;
  light) gsettings set org.gnome.desktop.interface color-scheme prefer-default ;;
esac
