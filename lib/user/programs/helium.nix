{
  username,
  pkgs,
  inputs,
  ...
}:

let
  helium = inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default;

  helium-print = pkgs.symlinkJoin {
    name = "helium-print";
    paths = [ helium ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm "$out/bin/helium"
      makeWrapper ${helium}/bin/helium "$out/bin/helium" \
        --prefix LD_LIBRARY_PATH : "${pkgs.gtk3}/lib" \
        --add-flags "--disable-print-preview"
    '';
  };
in
{
  hjem.users.${username}.packages = [ helium-print ];

  environment.etc."chromium/policies/managed/extensions.json".text = builtins.toJSON {
    ExtensionSettings = {
      "nngceckbapebfimnlniiiahkandclblb" = {
        installation_mode = "force_installed";
        update_url = "https://update-url-to-be-replaced.qjz9zk";
      };
    };
  };
}
