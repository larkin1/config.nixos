{ pkgs, inputs, hostname, username, ... }:

{
  hjem.users."${username}" = {
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

    files = {
      ".config/hypr".source = pkgs.symlinkJoin {
        name = "hypr-config";
        paths = [
          ../../../configs/hypr
          (pkgs.writeTextDir "lua/monitors.lua" (builtins.readFile ../../../hosts/${hostname}/home/monitors.lua))
          (pkgs.writeTextDir "lua/devices.lua" (builtins.readFile ../../../hosts/${hostname}/home/devices.lua))
        ];
      };

      ".config/wallpapers".source = "${inputs.config-walls}";
    };
  };

  # Enable hyprland and let x11 apps run
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # -- required for function menu --
  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };

  services.playerctld.enable = true;
}
