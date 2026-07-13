{ pkgs, inputs, username, ... }:

let # <temporary, hacky fix.>
  pkgsPinned = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/67650575de1a9c27262b96b2608f7d41ae311a0b.tar.gz";
    sha256 = "00c729p8gqka57hbvsx09rxmbzc3g05pxgv0vgg5h0jcnghap3sr";
  }) {
    inherit (pkgs) system;
    config.allowUnfreePredicate = pkg: (pkgs.lib.getName pkg == "spotify");
  };
in # </temporary, hacky fix.>
{
  hjem.extraModules = [ inputs.spicetify-nix.hjemModules.default ];

  hjem.users."${username}" = {
    programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      spicetifyPackage = pkgsPinned.spicetify-cli; # temporary, hacky fix

      enabledExtensions = with spicePkgs.extensions; [
        adblock
      ];

      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
