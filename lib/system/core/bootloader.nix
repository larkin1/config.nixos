{ lib, ... }:

{ # --- Bootloader config ---

  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      timeout = lib.mkDefault 0;

      limine = {
        enable = true;
        extraConfig = ''
          term_palette: 1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
          term_palette_bright: 585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4
          interface_branding_color: b4befe
          interface_help_color: b4befe
          interface_help_color_bright: b4befe
        '';
          # term_foreground: cdd6f4
          # term_background_bright: 585b70
          # term_foreground_bright: cdd6f4
          # term_background: 1e1e2e
        style = {
          wallpapers = [
            (builtins.fetchurl {
              url = "https://w.wallhaven.cc/full/x6/wallhaven-x6x3gz.png";
              sha256 = "1cwr17505kfllz39bp1gzm0jkh1mamfjil25ablqbngpm32ngyv2";
            })
          ];
          backdrop = null;
        };
      };
    };
  };
}
