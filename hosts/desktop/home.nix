{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ../../lib/home/dots.nix
    ../../lib/home/hypr.nix
    ../../lib/home/user.nix
    ../../lib/home/git.nix
    ../../lib/home/fonts.nix
    ../../lib/home/spotify.nix
    ../../lib/home/zsh.nix
    ../../lib/home/nvim.nix
  ];

  # config files
  home.file.".config/hypr/lua/monitors.lua".text = ''
    hl.monitor({
      output = "DP-1",
      mode = "highrr",
      position = "0x0",
      scale = "1",
    })

    hl.monitor({
      output = "DP-2",
      mode = "highrr",
      position = "2560x-300",
      scale = "1",
      transform = 1,
    })

    hl.monitor({
      output = "DP-3",
      mode = "highrr",
      position = "-1080x-300",
      scale = "1",
      transform = 3,
    })
  '';
   home.file.".config/hypr/lua/devices.lua".text = ''
   -- no per-device config
  '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    cameractrls
    inputs.helium.packages.${system}.default
    onlyoffice-desktopeditors
    nix-output-monitor
    waybar
    zip
    unzip
    jq
    glow
    btop
    firefox
    google-chrome
    ghostty
    fuzzel
    vesktop
    cava
    yazi
    timg
    cliphist
    wl-clipboard
    bemoji
    zoom-us
    quickshell
    qbittorrent
  ];

  services.playerctld.enable = true;

  # safe to ignore
  home.stateVersion = "26.05";
}
