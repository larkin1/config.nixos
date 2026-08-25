{ pkgs, username, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      foomatic-db-ppds
    ];
  };

  hardware.printers.ensurePrinters = [{
    name = "SHARP_MX2651";
    deviceUri = "socket://192.168.0.116:9100";
    model = "foomatic-db-ppds/Generic-PCL_6_PCL_XL_Printer-pxlcolor.ppd.gz";
    ppdOptions = {
      PageSize = "A4";
    };
  }];

  users.users.${username}.extraGroups = [ "lpadmin" "lp" ];
}
