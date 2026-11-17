{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.server = {
    backup = lib.mkOption {
      description = "directories to backup. uses rsync";
      default = { };
      type = lib.types.attrsOf (
        lib.types.submodule (
          { name, config, ... }: {
            options = {
              user = lib.mkOption {
                type = lib.types.str;
                default = "root";
                description = "user the service should run as";
              };
              group = lib.mkOption {
                type = lib.types.str;
                default = config.user;
              };
              inPath = lib.mkOption {
                type = lib.types.str;
                description = "path to copy. trailing `/` is automatically appended. do not include.";
              };
              outPath = lib.mkOption {
                description = "path to write backps to. trailing `/` is automatically appended. do not include.";
                type = lib.types.str;
                default = "/var/backup/${name}";
              };
              time = lib.mkOption {
                type = lib.types.str;
                default = "*-*-* 01:00:00";
              };
              extraArgs = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [ ];
                description = "extra arguments to pass to rsync. eg `--exclude=lost+found`";
              };
            };
          }
        )
      );
    };
  };

  config.systemd = {
    services = lib.mapAttrs' (
      name: val:
      lib.nameValuePair ("backup-" + name) ({
        serviceConfig = {
          Type = "oneshot";
          User = val.user;
        };
        path = [ pkgs.rsync ];
        script = ''
          rsync -a --delete --exclude="**/.backup-stamp" ${lib.escapeShellArgs val.extraArgs} \
            ${lib.escapeShellArg val.inPath}/ ${lib.escapeShellArg val.outPath}/
          touch "${lib.escapeShellArg val.outPath}/.backup-stamp"
        '';
        startAt = val.time;
        unitConfig.RequiresMountsFor = val.outPath;
      })
    ) config.server.backup;

    tmpfiles.settings = lib.mapAttrs' (
      name: val:
      lib.nameValuePair ("backup-${name}") ({
        "${val.outPath}".d = {
          mode = "0700";
          user = val.user;
          group = val.group;
        };
      })
    ) config.server.backup;
  };
}
