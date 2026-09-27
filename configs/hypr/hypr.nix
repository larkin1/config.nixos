{ pkgs, config, hostname, username, ... }:

let
  name = "hypr";
  input = "${config.custom.theming.templatesDir}/${name}";
  output = ".config/${name}/lua/theme.lua";
in {
  config = {
    custom.theming.toml.${name} = ''
      [templates.${name}]
      input_path = "/home/${username}/${input}"
      output_path = "/home/${username}/${output}"
    '';

    hjem.users.${username} = {
      packages = with pkgs; [
        hyprland
        hypridle
        hyprpaper
        hyprcursor
        rose-pine-hyprcursor
        grim
        slurp
        satty
        libnotify
        dunst
        jq
        cliphist
        wl-clipboard
        bemoji
      ];

        # ".config/wallpapers".source = "${inputs.config-walls}";
      files = let path = ".config/hypr"; in {
        ".zlogin".text = ''
          if uwsm check may-start; then
            exec uwsm start hyprland.desktop
          fi
        '';

        "${input}".text = ''
          return {
              image = "{{image}}",
          <* for name, value in colors *>
              {{name}} = "0xff{{value.default.hex_stripped}}",
          <* endfor *>
          }
        '';

        ".config/hypr/hyprpaper.conf".text = ''
          wallpaper {
            monitor =
            path = /home/${username}/.config/walls/${config.custom.theming.wallpaperName}
          }
        '';

        ".config/walls".source =pkgs.callPackage ../walls/walls.nix { };

        "${path}/hypridle.conf".text = ''
          listener {
            timeout = 120
            on-timeout = hyprctl 'dispatch hl.dsp.dpms({ action = "disable" })'
            on-resume = hyprctl 'dispatch hl.dsp.dpms({ action = "enable" })'
          }
        '';

        "${path}/lua/devices.lua".source = ../../hosts/${hostname}/home/devices.lua;
        "${path}/lua/monitors.lua".source = ../../hosts/${hostname}/home/monitors.lua;
        "${path}/lua/env.lua".source = ./lua/env.lua;
        "${path}/lua/bindings.lua".source = ./lua/bindings.lua;
        "${path}/lua/rules.lua".source = ./lua/rules.lua;
        "${path}/lua/startup.lua".source = ./lua/startup.lua;
        "${path}/lua/vars.lua".source = ./lua/vars.lua;
        "${path}/lua/vibes.lua".source = ./lua/vibes.lua;
        "${path}/hyprland.lua".source = ./hyprland.lua;
        "${path}/scripts/fuzzel-emoji-picker.sh".source = ./scripts/fuzzel-emoji-picker.sh;
      };
    };

    # Enable hyprland and let x11 apps run
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    # -- required for function menu --
    services.locate = {
      enable = true;
      package = pkgs.plocate;
    };

    services.playerctld.enable = true;
  };
}
