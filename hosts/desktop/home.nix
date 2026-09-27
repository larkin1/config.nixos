{ pkgs, inputs, username, ... }:

{
  imports = [
    ../../lib/user/user.nix
    ../../lib/user/cli/git.nix
    ../../lib/user/cli/zsh.nix
    ../../lib/user/cli/nvim.nix
    ../../lib/user/desktop/dots.nix
    ../../lib/user/programs/spotify.nix
    ../../lib/user/programs/defaults.nix
  ];

  # environment.systemPackages = [(inputs.booru-hs.packages.${pkgs.system}.default)];

  hjem.users."${username}" = {
    packages = with pkgs; [

      # -- Desktop apps --
      inputs.helium.packages.${system}.default
      firefox
      vesktop
      zoom-us
      onlyoffice-desktopeditors
      prusa-slicer

      inputs.matugen.packages.${system}.default
      inputs.booru-hs.packages.${system}.default

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
