{ pkgs, ... }:
let
  manifest = builtins.fromJSON (builtins.readFile ./walls.lock);
in
pkgs.linkFarm "wallpapers" (
  map (e: {
    inherit (e) name;
    path = pkgs.fetchurl {
      inherit (e) url sha256;
    };
  }) manifest
)
