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
        "${input}".source = ./yazi/theme.toml;
        "${output}/keymap.toml".source = ./yazi/keymap.toml;
        "${output}/yazi.toml".source = ./yazi/yazi.toml;
        ".config/xdg-desktop-portal-termfilechooser".source = ./xdg-desktop-portal-termfilechooser;
      };
    };
  };
}
