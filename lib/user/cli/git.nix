{ pkgs, username, ... }:

{
  hjem.users."${username}" = {
    packages = with pkgs; [
      git
    ];
    files = {
      ".config/git/config".text = ''
        [user]
          email = "git@sprk.foo"
          name = "larkin1"
      '';
    };
  };
}
