{ config, pkgs, ... }:

{
  xdg.configFile."cava" = {
    source = ../../configs/cava;
    recursive = false;
  };

  xdg.configFile."dunst" = {
    source = ../../configs/dunst;
    recursive = false;
  };

  xdg.configFile."fuzzel" = {
    source = ../../configs/fuzzel;
    recursive = false;
  };

  xdg.configFile."ghostty" = {
    source = ../../configs/ghostty;
    recursive = false;
  };

  xdg.configFile."starship" = {
    source = ../../configs/starship;
    recursive = false;
  };

  xdg.configFile."waybar" = {
    source = ../../configs/waybar;
    recursive = false;
  };

  xdg.configFile."yazi" = {
    source = ../../configs/yazi;
    recursive = false;
  };

}
