{ pkgs, config, username, ... }:

let
  c = config.programs.matugen.theme.colors;
  stripped = v: builtins.replaceStrings [ "#" ] [ "" ] v;
in {
  hjem.users.${username} = {
    packages = with pkgs; [
      fuzzel
    ];
    files = {
      ".config/fuzzel/fuzzel.ini".text = ''
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
        background=${stripped c.background.dark.color}aa
        text=${stripped c.on_surface.dark.color}ff
        prompt=${stripped c.secondary.dark.color}ff
        placeholder=${stripped c.tertiary.dark.color}ff
        input=${stripped c.primary.dark.color}ff
        match=${stripped c.tertiary.dark.color}ff
        selection=${stripped c.primary.dark.color}55
        selection-text=${stripped c.on_surface.dark.color}ff
        selection-match=${stripped c.on_primary.dark.color}ff
        counter=${stripped c.secondary.dark.color}ff
        border=${stripped c.primary.dark.color}ff

        [border]
        width=2
      '';
    };
  };
}
