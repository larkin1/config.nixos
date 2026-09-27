{ pkgs, ... }:
let
  manifest = builtins.fromJSON (builtins.readFile ./walls.json);
in
pkgs.linkFarm "wallpapers" (map (e: {
  name = e.name;
  path = pkgs.fetchurl { url = e.url; sha256 = e.sha256; };
}) manifest)
