{ ... }:

{ # Anything that is required to run any DE
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  security.polkit.enable = true;
  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];
}
