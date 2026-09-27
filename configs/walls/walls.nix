{ pkgs, ... }:

let
  ids = [
    "j5mz95"
    "gpjm3d"
    "57d827"
    "49down"
    "72j21e"
  ];

  pathOf = id:
    (builtins.fromJSON
      (builtins.readFile (builtins.fetchurl "https://wallhaven.cc/api/v1/w/${id}"))
    ).data.path;

  wall = id:
    let url = pathOf id; in {
      name = builtins.baseNameOf url;
      path = builtins.fetchurl url;
    };
in
pkgs.linkFarm "wallhaven-walls" (map wall ids)
