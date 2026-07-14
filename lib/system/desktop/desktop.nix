{ ... }:

{ # Anything that is required to run any DE
  hardware.graphics.enable = true;
  security.polkit.enable = true;
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];
}
