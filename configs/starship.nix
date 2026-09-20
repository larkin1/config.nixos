{ pkgs, config, username, ... }:

let
  c = config.programs.matugen.theme.colors;
in {
  hjem.users.${username} = {
    packages = with pkgs; [
      starship
    ];
    files = {
      ".config/starship/starship.toml".text = ''
        "$schema" = 'https://starship.rs/config-schema.json'

        scan_timeout = 100

        palette = "colors"

        # Starship modules
        [character]
        success_symbol = "[[󰄛](color9 bold) ❯](color8)"
        error_symbol = "[[󰄛](@{error}) ❯](color8)"
        vimcmd_symbol = "[󰄛 ❮](#f9e2af)"

        [git_branch]
        style = "bold color9"

        [directory]
        truncation_length = 4
        style = "bold color8"

        [palettes.colors]
        color1 = '${c.primary_fixed_dim.dark.color}'
        color2 = '${c.on_primary.dark.color}'
        color3 = '${c.on_surface_variant.dark.color}'
        color4 = '${c.surface_container.dark.color}'
        color5 = '${c.on_primary.dark.color}'
        color6 = '${c.surface_dim.dark.color}'
        color7 = '${c.surface.dark.color}'
        color8 = '${c.primary.dark.color}'
        color9 = '${c.tertiary.dark.color}'
      '';
    };
  };
}
