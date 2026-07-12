{ username, ... }:

{
  users.users."${username}" = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "nix";
  };

  hjem.users."${username}" = {
    clobberFiles = true;
    user = "${username}";
    # enable = true; # true by default.
    directory = "/home/${username}";
  };
}
