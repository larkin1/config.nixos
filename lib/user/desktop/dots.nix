{ pkgs, username, ... }:

{
  imports = [
    ../../../configs/cava.nix
    ../../../configs/dunst.nix
    ../../../configs/fuzzel.nix
    ../../../configs/ghostty.nix
    ../../../configs/starship.nix
    ./matugen.nix
  ];
  hjem.users."${username}" = {
    packages = with pkgs; [
      yazi
      ripdrag
      # fuzzel
      # ghostty
      # starship
    ];
    files = {
      # ".config/cava".source =     ../../../configs/cava;
      ".config/yazi".source =     ../../../configs/yazi;
      # ".config/dunst".source =    ../../../configs/dunst;
      # ".config/fuzzel".source =   ../../../configs/fuzzel;
      # ".config/ghostty".source =  ../../../configs/ghostty;
      # ".config/starship".source = ../../../configs/starship;
    };
  };
}

