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
      position = "1920x-450",
      scale = "1",
      transform = 3,
    })
  '';
   home.file.".config/hypr/lua/devices.lua".text = ''
   -- no per-device config
  '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    orca-slicer
    obs-studio
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
    gtk3
    (pkgs.writeShellScriptBin "orca-slicer-fixed" ''
      GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas" \
        orca-slicer "$@"
    '') # wrapper script to launch orcaslicer
  ];

  # new desktop file for orcaslicer
  # You might think "why not just put the wrapper script directly into the desktop launcher?
  # and you would be right to think that, but for some reason, fuzzel doesn't launch it properly
  # when it's wrapped directly into the desktop file... idk why, but this solution works ok?
  xdg.desktopEntries."com.orcaslicer.OrcaSlicer" = {
    name = "OrcaSlicer";
    exec = "orca-slicer-fixed %U";
    icon = "OrcaSlicer";
    terminal = false;
    categories = [ "Graphics" "3DGraphics" "Engineering" ];
  };

  services.playerctld.enable = true;

  # safe to ignore
  home.stateVersion = "26.05";
}
