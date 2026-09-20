{ pkgs, config, username, ... }:

let
  name = "cava";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/${name}/config";
in {
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
      post_hook = "pkill -USR1 cava"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        cava
      ];

      files = {
        "${input}".text = ''
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
          foreground = '{{colors.primary.default.hex}}'

          ; gradient = 0
          gradient = 1
          gradient_color_1 = '{{colors.primary_container.default.hex}}'
          gradient_color_2 = '{{colors.primary.default.hex}}'
          gradient_color_3 = '{{colors.on_primary_container.default.hex}}'

          horizontal_gradient = 1
          ; horizontal_gradient = 1
          horizontal_gradient_color_1 = '{{colors.primary_container.default.hex}}'
          horizontal_gradient_color_2 = '{{colors.primary.default.hex}}'
          horizontal_gradient_color_3 = '{{colors.on_primary_container.default.hex}}'
          horizontal_gradient_color_4 = '{{colors.primary.default.hex}}'
          horizontal_gradient_color_5 = '{{colors.primary_container.default.hex}}'


          [smoothing]
          noise_reduction = 85
        '';
      };
    };
  };
}
