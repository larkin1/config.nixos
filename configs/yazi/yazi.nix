{ pkgs, config, username, ... }:

let
  name = "yazi";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/${name}";
in {
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}/theme.toml"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        yazi
        ripdrag
      ];

      files = { # these are large files (200+ lines), so they are given their own files and read from those.
        "${input}".source = ./theme.toml;
        "${output}/keymap.toml".source = ./keymap.toml;
        "${output}/yazi.toml".source = ./yazi.toml;
        ".config/xdg-desktop-portal-termfilechooser".source = ./filechooser;
      };
    };
    # xdg stuff
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-termfilechooser
      ];
      config = {
        common = {
          default = ["gtk"];
        };
        hyprland = {
          default = [ "hyprland" "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
        };
      };
    };

    environment.variables = {
      GTK_USE_PORTAL = "1";
      GDK_DEBUG = "portals";
    };
  };
}
