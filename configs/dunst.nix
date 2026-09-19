{ pkgs, config, username, ... }:

let
  c = config.programs.matugen.theme.colors;
in {
  hjem.users.${username} = {
    packages = with pkgs; [
      dunst
    ];
    files = {
      ".config/dunst/dunstrc".text = ''
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
        frame_color = "${c.primary.dark.color}"
        highlight = "${c.primary.dark.color}"
        separator_color= "${c.outline.dark.color}"

        [urgency_low]
        timeout = 5
        background = "${c.surface.dark.color}"
        foreground = "${c.on_surface.dark.color}"
        highlight = "${c.primary_container.dark.color}"

        [urgency_normal]
        timeout = 5
        background = "${c.surface.dark.color}"
        foreground = "${c.on_surface.dark.color}"
        highlight = "${c.primary_container.dark.color}"

        [urgency_critical]
        timeout = 0
        background = "${c.surface.dark.color}"
        foreground = "${c.on_surface.dark.color}"
        highlight = "${c.error.dark.color}"
      '';
    };
  };
}
