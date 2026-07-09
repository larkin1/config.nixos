{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ../../lib/system/base-user.nix # temporary
    ../../lib/user/hypr.nix
    ../../lib/user/dots.nix
    ../../lib/user/nvim.nix
  ];  
  users.users."${username}" = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  hjem.users."${username}" = {
    user = "${username}";
    directory = "/home/${username}";

    files = {
      # ".config/nvim".source = "${inputs.config-nvim}";
    };

    packages = with pkgs; [
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
      hyprland
      hypridle
      hyprpaper
      hyprcursor
      rose-pine-hyprcursor
      grim
      slurp
      satty
      libnotify
      dunst
      starship
      ripgrep
      eza
      zoxide
      bat
      fzf
      fd
    ];
  };
}
