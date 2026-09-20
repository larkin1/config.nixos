{ pkgs, config, username, ... }:

let
  name = "dunst";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/${name}/dunstrc";
in {
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
      post_hook = "dunstctl reload"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        dunst
      ];

      files = {
        "${input}".text = ''
          [global]
          follow = mouse
          font = JetBrainsMono NFM 10
          width = 400
          height = (0, 200)
          offset = (5, 10)
          origin = top-right
          gap_size = 5
          corner_radius = 8
          frame_width = 2
          separator_height = 2
          padding = 8
          horizontal_padding = 12
          timeout = 5
          history_length = 100
          notification_limit = 20
          sort = update
          frame_color = "{{colors.primary.default.hex}}"
          highlight = "{{colors.primary.default.hex}}"
          separator_color= "{{colors.outline.default.hex}}"

          [urgency_low]
          timeout = 5
          background = "{{colors.surface.default.hex}}"
          foreground = "{{colors.on_surface.default.hex}}"
          highlight = "{{colors.primary_container.default.hex}}"

          [urgency_normal]
          timeout = 5
          background = "{{colors.surface.default.hex}}"
          foreground = "{{colors.on_surface.default.hex}}"
          highlight = "{{colors.primary_container.default.hex}}"

          [urgency_critical]
          timeout = 0
          background = "{{colors.surface.default.hex}}"
          foreground = "{{colors.on_surface.default.hex}}"
          highlight = "{{colors.error.default.hex}}"
        '';
      };
    };
  };
}
