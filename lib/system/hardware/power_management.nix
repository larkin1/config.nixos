{ ... }:

{ # --- Power management (LLM Code) ---

  # TLP
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
}
