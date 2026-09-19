{ pkgs, config, username, ... }:

let
  c = config.programs.matugen.theme.colors;
in {
  hjem.users.${username} = {
    packages = with pkgs; [
      cava
    ];
    files = {
      ".config/cava/config".text = ''
        [general]
        framerate = 50
        bar_width = 2
        bar_spacing = 1

        [output]
        method = noncurses
        orientation = horizontal
        channels = stereo
        horizontal_stereo = 1

        [color]
        background = 'default'
        foreground = '${c.primary.dark.color}'

        ; gradient = 0
        gradient = 1
        gradient_color_1 = '${c.primary_container.dark.color}'
        gradient_color_2 = '${c.primary.dark.color}'
        gradient_color_3 = '${c.on_primary_container.dark.color}'

        horizontal_gradient = 1
        ; horizontal_gradient = 1
        horizontal_gradient_color_1 = '${c.primary_container.dark.color}'
        horizontal_gradient_color_2 = '${c.primary.dark.color}'
        horizontal_gradient_color_3 = '${c.on_primary_container.dark.color}'
        horizontal_gradient_color_4 = '${c.primary.dark.color}'
        horizontal_gradient_color_5 = '${c.primary_container.dark.color}'


        [smoothing]
        noise_reduction = 85
      '';
    };
  };
}
