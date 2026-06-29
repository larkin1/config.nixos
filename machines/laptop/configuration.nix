# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp.useTmpfs = true;

  networking.hostName = "laptop"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Power management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Disable turbo on battery
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # Platform profiles (Intel Evo supports this)
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Aggressive PCI runtime PM
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      # WiFi power save
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # NVMe power management
      DISK_IOSCHED = "none";
      PCIE_ASPM_ON_BAT = "powersupersave";
    };
  };

  # Handles lid close, power button etc.
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
  };

  # Power profiles daemon conflicts with TLP — disable it
  services.power-profiles-daemon.enable = false;

  # Enable thermald for Intel thermal management
  services.thermald.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x8086", ATTR{device}=="0x272b", ATTR{d3cold_allowed}="0"
  '';

  # Re-apply after every resume since s2idle can reset it
  systemd.services.disable-wifi-d3cold = {
    description = "Disable D3cold for Intel BE200 Wi-Fi";
    wantedBy = [ "multi-user.target" "post-resume.target" ];
    after = [ "systemd-udevd.service" "post-resume.target" ];
    script = ''
      echo 0 > /sys/bus/pci/devices/0000:55:00.0/d3cold_allowed
    '';
    serviceConfig.Type = "oneshot";
  };

  boot.kernelParams = [ "amd_iommu=pt" "iwlwifi.enable_ini=0" ];
  hardware.amdgpu.opencl.enable = true;  # keep opencl available

  swapDevices = [{
    device = "/swapfile";
    size = 8192;
  }];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."larkin" = {
    isNormalUser = true;
    description = "Larkin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
  neovim
  wget
  git
  bluez
  brightnessctl
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };

  environment.variables.EDITOR = "nvim";

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

  hardware.graphics.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  system.stateVersion = "26.05";

}
