{ ... }:

{ # --- Bootloader config ---

  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      # "logo.nologo"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 3;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        theme = ../../../configs/grub;
        backgroundColor = "#1E1E2E";
        gfxmodeEfi = "auto";
      };
    };
  };
}
