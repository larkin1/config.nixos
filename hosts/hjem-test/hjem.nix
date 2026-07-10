{ pkgs, inputs, username, ... }:

{
  imports = [
    ../../lib/system/base-user.nix # temporary, avoids killing the existing user
    ../../lib/user/zsh.nix
    ../../lib/user/git.nix
    ../../lib/user/hypr.nix
    ../../lib/user/dots.nix
    ../../lib/user/nvim.nix
    ../../lib/user/spotify.nix
  ];  
  users.users."${username}" = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "nix";
  };

  hjem.users."${username}" = {
    clobberFiles = true;
    user = "${username}";
    directory = "/home/${username}";

    files = {
    };

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
