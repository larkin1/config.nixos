{ pkgs, inputs, username, ... }:

{
  imports = [
    ../../lib/user/user.nix
    ../../lib/user/cli/git.nix
    ../../lib/user/cli/zsh.nix
    ../../lib/user/cli/nvim.nix
    ../../lib/user/desktop/dots.nix
    ../../lib/user/desktop/hypr.nix
    ../../lib/user/desktop/quickshell.nix
    ../../lib/user/programs/spotify.nix
    ../../lib/user/programs/defaults.nix
  ];

  hjem.users."${username}" = {
    packages = with pkgs; [

      # -- Desktop apps --
      inputs.helium.packages.${system}.default
      firefox
      vesktop
      onlyoffice-desktopeditors

      # -- cli/tui tools --
      zip
      unzip
      btop
      timg

      # -- misc --
      cloudflared
    ];
  };

  environment.variables = {
    GTK_USE_PORTAL = "1";
    GTK_DEBUG = "portals";
  };

  xdg = {
    mime.enable = true;
    portal =  {
      enable = true;
      config = {
        common.default = [ "*" ];
        common."org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-termfilechooser
      ];
    };
  };
}
