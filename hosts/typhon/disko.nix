_:

let
  ssds = [
    "wwn-0x55cd2e414e0f08f3"
    "wwn-0x55cd2e414e0f0900"
    "wwn-0x55cd2e414e0f38c3"
    "wwn-0x55cd2e414e0f38da"
  ];
  hdds = [
    "wwn-0x5000c500a00ed34f"
    "wwn-0x5000c500a063f87f"
    "wwn-0x5000c500a0641463"
    "wwn-0x5000c500a08a1267"
  ];

  disk = id: partitions: {
    type = "disk";
    device = "/dev/disk/by-id/${id}";
    content = {
      type = "gpt";
      inherit partitions;
    };
  };
  esp = mountpoint: {
    size = "1G";
    type = "EF00";
    content = {
      type = "filesystem";
      format = "vfat";
      inherit mountpoint;
      mountOptions = [ "umask=0077" ];
    };
  };
  zfs = pool: {
    size = "100%";
    content = {
      type = "zfs";
      inherit pool;
    };
  };

  fsOptions = {
    compression = "zstd";
    acltype = "posixacl";
    xattr = "sa";
    atime = "off";
    mountpoint = "none";
    "com.sun:auto-snapshot" = "false";
  };
  legacy = mountpoint: {
    type = "zfs_fs";
    inherit mountpoint;
    options.mountpoint = "legacy";
  };
  at = builtins.elemAt;
in
{
  disko.devices = {
    disk = {
      ssd0 = disk (at ssds 0) {
        ESP = esp "/boot";
        zfs = zfs "rpool";
      };
      ssd1 = disk (at ssds 1) {
        ESP = esp "/boot-fallback";
        zfs = zfs "rpool";
      };
      ssd2 = disk (at ssds 2) { zfs = zfs "rpool"; };
      ssd3 = disk (at ssds 3) { zfs = zfs "rpool"; };
      hdd0 = disk (at hdds 0) { zfs = zfs "tank"; };
      hdd1 = disk (at hdds 1) { zfs = zfs "tank"; };
      hdd2 = disk (at hdds 2) { zfs = zfs "tank"; };
      hdd3 = disk (at hdds 3) { zfs = zfs "tank"; };
    };

    zpool = {
      rpool = {
        type = "zpool";
        mode.topology = {
          type = "topology";
          vdev = [
            {
              mode = "mirror";
              members = [
                "ssd0"
                "ssd1"
              ];
            }
            {
              mode = "mirror";
              members = [
                "ssd2"
                "ssd3"
              ];
            }
          ];
        };
        options.ashift = "12";
        rootFsOptions = fsOptions;
        datasets = {
          root = legacy "/";
          nix = legacy "/nix";
          var = legacy "/var";
          home = legacy "/home";
          reserved = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              refreservation = "20G";
            };
          };
        };
      };

      tank = {
        type = "zpool";
        mode = "raidz1";
        options.ashift = "12";
        rootFsOptions = fsOptions;
        datasets.srv = legacy "/srv";
      };
    };
  };
}
