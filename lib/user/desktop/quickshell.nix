{ pkgs, username, inputs, ... }:

{
  hjem.users."${username}" = {
    packages = with pkgs; [
      quickshell
      wf-recorder # required for screen recording to work
    ];
    files = {
      ".config/quickshell".source = "${inputs.config-quickshell}";
    };
  };
  services.upower.enable = true; # for battery/power monitoring
}
