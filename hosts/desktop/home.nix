{ pkgs, username, ... }:

{
  imports = [
    ../../lib/user/user.nix
    ../../lib/user/cli/git.nix
    ../../lib/user/cli/zsh.nix
    ../../lib/user/cli/nvim.nix
    ../../lib/user/desktop/dots.nix
    ../../lib/user/programs/spotify.nix
    ../../lib/user/programs/defaults.nix
    ../../lib/user/programs/helium.nix
  ];

  hjem.users."${username}" = {
    packages = with pkgs; [

      # -- Desktop apps --
      vesktop
      zoom-us
      onlyoffice-desktopeditors
      prusa-slicer

      # -- cli/tui tools --
      zip
      unzip
      btop
      timg
      cameractrls
      ffmpeg # mostly for ffplay

      # -- misc --
      cloudflared
    ];
  };
}
