{ config, pkgs, inputs, ... }:

{
  imports = [
    # inputs.spicetify-nix.homeManagerModules.default
    ../../common/home/dots.nix
    ../../common/home/hypr.nix
    ../../common/home/user.nix
    ../../common/home/git.nix
    ../../common/home/fonts.nix
    # ../../common/home/spotify.nix
    ../../common/home/zsh.nix
  ];

  home.file.".config/hypr/lua/monitors.lua".text = ''
    hl.monitor({
      output = "",
      mode = "highrr",
      position = "auto",
      scale = "1",
    })
  '';
   home.file.".config/hypr/lua/devices.lua".text = ''
   -- no per-device config
  '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # onlyoffice-desktopeditors
    nix-output-monitor
    waybar
    zip
    unzip
    jq
    glow 
    btop
    firefox
    ghostty
    fuzzel
    cava
    yazi
    timg
    cliphist
    wl-clipboard
    bemoji
    tree-sitter
    gcc
  ];

  services.playerctld.enable = true;
  
  # safe to ignore
  home.stateVersion = "26.05";
}
