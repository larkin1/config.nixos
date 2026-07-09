{ config, pkgs, ... }:

{ # --- Normal, basic user config ---

  # Account setup
  users.users."larkin" = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
  
  # Enable zsh since we define `users.users.<user>.shell` as zsh
  programs.zsh.enable = true;
}
