{ pkgs, inputs, username, ... }:

{
  imports = [
    ../../lib/user/dots.nix
    ../../lib/user/hypr.nix
    ../../lib/user/git.nix
    ../../lib/user/spotify.nix
    ../../lib/user/zsh.nix
    ../../lib/user/nvim.nix
    ../../lib/user/user.nix
  ];

  hjem.users."${username}" = {
    packages = with pkgs; [

      # -- Desktop apps --
      inputs.helium.packages.${system}.default
      firefox
      google-chrome
      vesktop
      zoom-us
      qbittorrent
      onlyoffice-desktopeditors

      # -- cli/tui tools --
      zip
      unzip
      glow
      btop
      timg

      # -- misc --
      quickshell
    ];
  };
}
