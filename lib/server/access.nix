{ username, lib, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl/mea3a7cPnEYRbW446cLjBfC/zJZL6lLQrNMP4omN larkin@laptop" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+io/o/r9ymcw/Wo7QeiRMVd1gxx1xb6xVKD3cuRxua larkin@desktop"];
  };

  security.sudo.wheelNeedsPassword = lib.mkDefault false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
}
