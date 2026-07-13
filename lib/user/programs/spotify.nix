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

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];

      enabledSnippets = with spicePkgs.snippets; [
        pointer
      ];

      theme = spicePkgs.themes.hazy;
    };
  };
}
