{ pkgs, inputs, username, ... }:

{
  imports = [
    ../../lib/user/user.nix
    ../../lib/user/cli/git.nix
    ../../lib/user/cli/zsh.nix
    ../../lib/user/cli/nvim.nix
    ../../lib/user/desktop/dots.nix
    ../../lib/user/desktop/hypr.nix
    ../../lib/user/programs/spotify.nix
    ../../lib/user/programs/orcaslicer.nix
  ];

  hjem.users."${username}" = {
    packages = with pkgs; [

      # -- Desktop apps --
      inputs.helium.packages.${system}.default
      firefox
      vesktop
      zoom-us
      onlyoffice-desktopeditors
      obs-studio

      # -- cli/tui tools --
      zip
      unzip
      glow
      btop
      timg

      # -- misc --
      cloudflared
    ];
  };
}
