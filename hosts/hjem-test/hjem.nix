{ pkgs, inputs, username, ... }:

{
  imports = [
    # ../../lib/system/base-user.nix # temporary, avoids killing the existing user
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
      inputs.helium.packages.${system}.default
      onlyoffice-desktopeditors
      nix-output-monitor
      zip
      unzip
      glow
      btop
      firefox
      google-chrome
      vesktop
      timg
      zoom-us
      quickshell
      qbittorrent
    ];
  };
}
