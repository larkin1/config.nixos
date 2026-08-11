{ username, ... }:

{
  hjem.users.${username}.files.".config/mimeapps.list".text = ''
    [Default Applications]
    text/html=helium.desktop
    application/pdf=helium.desktop
    x-scheme-handler/http=helium.desktop
    x-scheme-handler/https=helium.desktop
    x-scheme-handler/chrome=helium.desktop
    application/x-extension-html=helium.desktop
    application/x-extension-shtml=helium.desktop
    application/xhtml+xml=helium.desktop
    application/x-extension-xhtml=helium.desktop
    application/x-extension-xht=helium.desktop
    x-scheme-handler/about=helium.desktop
    x-scheme-handler/unknown=helium.desktop
    x-scheme-handler/discord=vesktop.desktop
    x-scheme-handler/mailto=helium.desktop
  '';
}
