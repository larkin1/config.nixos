{ pkgs, username, ... }:

{
  imports = [
    ../../lib/user/user.nix
    ../../lib/user/cli/dev.nix
    ../../lib/user/desktop/dots.nix
    ../../lib/user/programs/defaults.nix
    ../../lib/user/programs/helium.nix
  ];

  hjem.users."${username}" = {
    packages = with pkgs; [

      # -- Desktop apps --
      vesktop
      onlyoffice-desktopeditors
      zoom-us
      mpv

      # -- cli/tui tools --
      zip
      unzip
      btop
      timg
      ffmpeg # mostly for ffplay

      # -- misc --
      cloudflared
    ];
  };

  nixpkgs.config.problems.handlers."gtk+".broken = "warn"; # TEMP until onlyoffice is updated
}
