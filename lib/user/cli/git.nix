{ pkgs, username, ... }:

{
  hjem.users."${username}" = {
    packages = with pkgs; [
      git
    ];
    files = {
      ".config/git/config".text = ''
        [user]
          email = "88820972+larkin1@users.noreply.github.com"
          name = "larkin1"
      '';
    };
  };
}
