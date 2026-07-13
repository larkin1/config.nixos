{ pkgs, username, ... }:

{
  hjem.users."${username}" = {
    packages = with pkgs; [
      cava
      yazi
      dunst
      fuzzel
      waybar
      ghostty
      starship
    ];
    files = {
      ".config/cava".source =     ../../configs/cava;
      ".config/yazi".source =     ../../configs/yazi;
      ".config/dunst".source =    ../../configs/dunst;
      ".config/fuzzel".source =   ../../configs/fuzzel;
      ".config/waybar".source =   ../../configs/waybar;
      ".config/ghostty".source =  ../../configs/ghostty;
      ".config/starship".source = ../../configs/starship;
    };
  };

  services.playerctld.enable = true; # required for waybar player widget to work correctly
}

