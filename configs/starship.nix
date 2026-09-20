{ pkgs, config, username, ... }:

let
  name = "starship";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/starship.toml";
in {
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        starship
      ];

      files = {
        "${input}".text = ''
          "$schema" = 'https://starship.rs/config-schema.json'

          scan_timeout = 100

          palette = "colors"

          # Starship modules
          [character]
          success_symbol = "[[󰄛](color9 bold) ❯](color8)"
          error_symbol = "[[󰄛]({{colors.error.default.hex}}) ❯](color8)"
          vimcmd_symbol = "[󰄛 ❮](color2)"

          [git_branch]
          style = "bold color9"

          [directory]
          truncation_length = 4
          style = "bold color8"

          [palettes.colors]
          color1 = '{{colors.primary_fixed_dim.default.hex}}'
          color2 = '{{colors.on_primary.default.hex}}'
          color3 = '{{colors.on_surface_variant.default.hex}}'
          color4 = '{{colors.surface_container.default.hex}}'
          color5 = '{{colors.on_primary.default.hex}}'
          color6 = '{{colors.surface_dim.default.hex}}'
          color7 = '{{colors.surface.default.hex}}'
          color8 = '{{colors.primary.default.hex}}'
          color9 = '{{colors.tertiary.default.hex}}'
        '';
      };
    };
  };
}
