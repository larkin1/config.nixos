{ pkgs, config, username, ... }:

let
  name = "gtk";
  input = "${config.custom.theming.templatesDir}/${name}";
  output3 = ".config/${name}-3.0";
  output4 = ".config/${name}-4.0";
in {
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
        "${output3}/gtk.css".source = ./gtk3.css;
        "${output4}/gtk.css".source = ./gtk4.css;
        ".local/share/glib-2.0/schemas".source = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.pname}-${pkgs.gsettings-desktop-schemas.version}/glib-2.0/schemas";
        # "${output3}/settings.ini".text = ''
        #   [Settings]
        #   gtk-theme-name=adw-gtk3
        #   gtk-application-prefer-dark-theme=true
        # '';
        ".config/matugen/post-hook-scripts/gtk-themes-reload.sh".source = ./gtk-themes-reload.sh;
      };
    };
    programs.dconf.enable = true;
  };

}
