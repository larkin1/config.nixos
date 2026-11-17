{ username, ... }:

{
  hjem.users.${username}.files.".config/mimeapps.list".text = ''
    [Default Applications]
    video/mp4=mpv.desktop
    video/webm=mpv.desktop
    video/quicktime=mpv.desktop
    video/x-matroska=mpv.desktop
    video/3gpp=mpv.desktop
    video/x-msvideo=mpv.desktop
    video/mpeg=mpv.desktop
    video/ogg=mpv.desktop
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
