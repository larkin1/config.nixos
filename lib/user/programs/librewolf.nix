{ username, pkgs, ... }:

let
  policiesJson = pkgs.writeText "librewolf-policies.json" (builtins.toJSON {
    policies = {
      ExtensionSettings = {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          default_area = "navbar";
          private_browsing = true;
        };
        "CanvasBlocker@kkapsner.de" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/canvasblocker/latest.xpi";
          private_browsing = true;
        };
      };
      Bookmarks = [
        {
          Title = "Onshape";
          URL = "https://cad.onshape.com";
        }
      ];
      SearchEngines = {
        Add = [
          {
            Name = "DuckDuckGo";
            URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
            IconURL = "https://duckduckgo.com/favicon.ico";
            SuggestURLTemplate = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";
          }
        ];
        Default = "DuckDuckGo";
        SkipTermsOfUse = true;
      };
    };
  });

in {
  hjem.users.${username} = {
    packages = [
      (pkgs.librewolf.override {
        extraPoliciesFiles =
          pkgs.librewolf-unwrapped.extraPoliciesFiles ++ [ policiesJson ];
      })
    ];

    files = {
      ".config/librewolf/librewolf/librewolf.overrides.cfg".text = ''
        defaultPref("privacy.resistFingerprinting", false);
        defaultPref("layout.css.prefers-color-scheme.content-override", 0);
        defaultPref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
        defaultPref("ui.systemUsesDarkTheme", 1);
        defaultPref("sidebar.verticalTabs", true);
        defaultPref("sidebar.visibility", "expand-on-hover");
        defaultPref("browser.toolbars.bookmarks.visibility", "newtab");
        defaultPref("browser.uiCustomization.state", '{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["canvasblocker_kkapsner_de-browser-action"],"nav-bar":["sidebar-button","back-button","forward-button","stop-reload-button","smartwindow-group-tabs-button","ai-window-toggle","reset-pbm-toolbar-button","vertical-spacer","urlbar-container","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","unified-extensions-button","downloads-button","fxa-toolbar-menu-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"]},"seen":["reset-pbm-toolbar-button","canvasblocker_kkapsner_de-browser-action","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","developer-button","screenshot-button"],"dirtyAreaCache":["unified-extensions-area","nav-bar","toolbar-menubar","TabsToolbar","vertical-tabs","PersonalToolbar"],"currentVersion":26,"newElementCount":3}');
      '';
    };
  };
}
