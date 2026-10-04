{ username, ... }:

{
  users.users."${username}" = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    initialPassword = "nix";
  };

  hjem.users."${username}" = {
    clobberFiles = true;
    user = "${username}";
    directory = "/home/${username}";
  };
  
  services.getty = {
    loginOptions = "-- ${username}";
    extraArgs = [ "--skip-login" ];
  };
}
