{ pkgs, lib, ... }:

{

  options.server = {
    backup = lib.mkOption {
      description = "Directories to backup";
      default = { };
      type = lib.types.attrsOf (
        lib.types.submodule (
          { name, config, ... }: {
            options = {
              name = lib.mkOption {
                type = lib.types.string;
                default = name;
              };
              inPath = lib.mkOption { type = lib.types.path; };
              outPath = lib.mkOption {
                type = lib.types.path;
                default = "/var/backup/${config.name}";
              };
              time = lib.mkOption {
                type = lib.types.string;
                default = "*-*-* 01:00:00";
              };
            };
          }
        )
      );
    };
  };

  systemd.services."vaultwarden-backup" = {
    serviceConfig = {
      Type = "oneshot";
      User = "vaultwarden";
      path = [ pkgs.rsync ];
      script = ''
        rsync -a --delete --exclude=lost+found --exclude=icon_cache/ --exclude=tmp/ \
          /var/lib/vaultwarden/ /var/backup/vaultwarden/
      '';
      startAt = "*-*-* 01:00:00";
    };
  };
}
