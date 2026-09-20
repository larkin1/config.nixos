{ pkgs, config, username, ... }:

let
  name = "fuzzel";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/${name}/fuzzel.ini";
in {
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        fuzzel
      ];

      files = {
        "${input}".text = ''
          font=JetBrainsMono Nerd Font:weight=medium:size=13
          dpi-aware=auto
          use-bold=yes
          placeholder="Run a program..."
          icons-enabled=no
          sort-result=common
          terminal=ghostty -e
          lines=15
          width=90
          horizontal-pad=10
          vertical-pad=10
          inner-pad=5

          [colors]
          background={{colors.background.default.hex_stripped}}aa
          text={{colors.on_surface.default.hex_stripped}}ff
          prompt={{colors.secondary.default.hex_stripped}}ff
          placeholder={{colors.tertiary.default.hex_stripped}}ff
          input={{colors.primary.default.hex_stripped}}ff
          match={{colors.tertiary.default.hex_stripped}}ff
          selection={{colors.primary.default.hex_stripped}}55
          selection-text={{colors.on_surface.default.hex_stripped}}ff
          selection-match={{colors.on_primary.default.hex_stripped}}ff
          counter={{colors.secondary.default.hex_stripped}}ff
          border={{colors.primary.default.hex_stripped}}ff

          [border]
          width=2
        '';
      };
    };
  };
}
