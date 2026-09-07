{ pkgs, inputs, username, ... }:

{
  hjem.extraModules = [ inputs.spicetify-nix.hjemModules.default ];

  hjem.users."${username}" = {
    programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      spicetifyPackage = pkgs.spicetify-cli;

      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        skipStats
        sortPlay
      ];

      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
