{ ... }:

{
  hardware.logitech.wireless.enable = true;

  services.logiops = {
    enable = true;
    config = {
      devices = [
      {
        name = "MX Master 4 Special Edition";
        buttons = [
          { cid = "416"; action = { type = "CycleDPI"; dpis = [ 400 900 ]; }; }
        ];
      }
      ];
    };
  };
}
