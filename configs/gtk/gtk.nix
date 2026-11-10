{
  pkgs,
  config,
  username,
  ...
}:

let
  name = "gtk";
  input = "${config.custom.theming.templatesDir}/${name}";
  output3 = ".config/${name}-3.0";
  output4 = ".config/${name}-4.0";

  selectionCss = ''
    textview.view text selection,
    textview.view text selection:focus,
    textview.view text selection:backdrop,
    .view text selection,
    .view text selection:focus {
      background-color: @matugen_selection_bg;
      color: @matugen_selection_fg;
    }
  '';
in
{
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}3]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output3}/colors.css"
      post_hook = "sh /home/larkin/.config/matugen/post-hook-scripts/gtk-themes-reload.sh {{mode}}"

      [templates.${name}4]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output4}/colors.css"
      post_hook = "sh /home/larkin/.config/matugen/post-hook-scripts/gtk-themes-reload.sh {{mode}}"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        adw-gtk3
        glib
      ];

      files = {
        "${input}".source = ./colors.css;
        "${output4}/gtk.css".source = ./gtk4.css;

        ".local/share/themes/adw-gtk3-matugen-dark/gtk-3.0/gtk.css".text = ''
          @import url("file://${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-3.0/gtk.css");
          @import url("file:///home/${username}/${output3}/colors.css");

          ${selectionCss}
        '';
        ".local/share/themes/adw-gtk3-matugen/gtk-3.0/gtk.css".text = ''
          @import url("file://${pkgs.adw-gtk3}/share/themes/adw-gtk3/gtk-3.0/gtk.css");
          @import url("file:///home/${username}/${output3}/colors.css");

          ${selectionCss}
        '';

        ".local/share/glib-2.0/schemas".source =
          "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.pname}-${pkgs.gsettings-desktop-schemas.version}/glib-2.0/schemas";
        ".config/matugen/post-hook-scripts/gtk-themes-reload.sh".source = ./gtk-themes-reload.sh;
      };
    };
    programs.dconf.enable = true;
  };

}
