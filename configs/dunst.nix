{
  pkgs,
  config,
  username,
  ...
}:

let
  name = "dunst";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/${name}/dunstrc";

  notifySound = pkgs.writeShellScript "dunst-sound" ''
    dir=${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo
    case "$DUNST_CATEGORY" in
      sound|sound.) snd=message ;;
      sound.*) snd="''${DUNST_CATEGORY#sound.}" ;;
      im.received) snd=message-new-instant ;;
      email.arrived) snd=message ;;
      device.added) snd=device-added ;;
      device.removed) snd=device-removed ;;
      network.connected) snd=network-connectivity-established ;;
      transfer.complete) snd=complete ;;
      *)
        case "$DUNST_URGENCY" in
          CRITICAL) snd=dialog-warning ;;
          *) exit 0 ;;
        esac
        ;;
    esac
    f="$dir/$snd.oga"
    [ -f "$f" ] || f="$dir/message.oga"
    exec ${pkgs.util-linux}/bin/flock -n "''${XDG_RUNTIME_DIR:-/tmp}/dunst-sound.lock" \
      ${pkgs.pipewire}/bin/pw-play "$f"
  '';
in
{
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
      post_hook = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus ${pkgs.dunst}/bin/dunstctl reload"
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
          mouse_left_click = do_action, close_current
          mouse_middle_click = close_current
          mouse_right_click = close_all

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

          [play_sound]
          summary = "*"
          script = ${notifySound}
        '';
      };
    };
  };
}
