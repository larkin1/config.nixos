{ config, pkgs, inputs, ... }:

{
  home.file.".config/hypr" = {
    source = "${inputs.config-hypr}";
    recursive = true;
  };

  home.file.".config/wallpapers" = {
    source = "${inputs.config-walls}";
    recursive = true;
  };

  home.packages = with pkgs; [
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
  ];
}
