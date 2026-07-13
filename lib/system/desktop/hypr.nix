{ config, pkgs, ... }:

{ # --- System config for hypr ecosystem ---

  # Enable hyprland and let x11 apps run
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # For plocate to be used (included in the quick menu)
  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };
}
