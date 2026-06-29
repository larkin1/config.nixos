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
      
  home.file.".config/ghostty" = {
    source = "${inputs.config-ghostty}";
    recursive = true;
  };

  home.file.".config/starship" = {
    source = "${inputs.config-starship}";
    recursive = true;
  };

  home.file.".config/cava" = {
    source = "${inputs.config-cava}";
    recursive = true;
  };

  home.file.".config/dunst" = {
    source = "${inputs.config-dunst}";
    recursive = true;
  };

  home.file.".config/fuzzel" = {
    source = "${inputs.config-fuzzel}";
    recursive = true;
  };

  home.file.".config/nvim" = {
    source = "${inputs.config-nvim}";
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = "${inputs.config-waybar}";
    recursive = true;
  };

  home.file.".config/yazi" = {
    source = "${inputs.config-yazi}";
    recursive = true;
  };
}
