{ pkgs, inputs, username, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  hjem.extraModules = [ inputs.spicetify-nix.hjemModules.default ];

  hjem.users."${username}" = {
    programs.spicetify = {
      enable = true;
      wayland = false;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];

      enabledSnippets = with spicePkgs.snippets; [
        # rotatingCoverart
        pointer
      ];

      theme = spicePkgs.themes.hazy;
    };
  };
}
