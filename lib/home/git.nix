{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "larkin1";
      user.email = "88820972+larkin1@users.noreply.github.com";
    };
  };
}
