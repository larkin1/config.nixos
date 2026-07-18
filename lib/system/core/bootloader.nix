{ ... }:

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
      timeout = 0;

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
              url = "https://w.wallhaven.cc/full/dg/wallhaven-dg5kkm.jpg";
              sha256 = "01lf4vs0pyn28z21jbjq0d8ylgc7j66vvl4c0p6ss14iqaana1n5";
            })
          ];
          backdrop = null;
        };
      };
    };
  };
}
