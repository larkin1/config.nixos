{ pkgs, username, inputs, ... }:

{
  hjem.users."${username}" = {
    packages = with pkgs; [
      quickshell
      wf-recorder # required for screen recording to work
    ];
    files = {
      ".config/quickshell-nixed".source = "${inputs.config-quickshell}"; # since it's in development, use a custom path for the config temporarily.
    };
  };
  services.upower.enable = true; # for battery/power monitoring
}
