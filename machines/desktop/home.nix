{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ../../common/home/dots.nix
    ../../common/home/hypr.nix
    ../../common/home/user.nix
    ../../common/home/git.nix
    ../../common/home/fonts.nix
    ../../common/home/spotify.nix
    ../../common/home/zsh.nix
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
    hl.device ({
      name="my-epic-mouse",
      sensitivity = -0.5,
    })
  '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
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
    tree-sitter
    gcc
    zoom-us
    quickshell
    qbittorrent
  ];

  services.playerctld.enable = true;
  
  # safe to ignore
  home.stateVersion = "26.05";
}
