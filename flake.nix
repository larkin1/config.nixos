{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "git+https://github.com/nixos/nixpkgs?ref=nixos-unstable&shallow=1";

    # --- Special Apps ---
    hjem = {
      url = "git+https://github.com/feel-co/hjem?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "git+https://github.com/schembriaiden/helium-browser-nix-flake?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "git+https://github.com/InioX/Matugen?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- Configurations ---
    config-nvim = { # i keep my nvim config in a separate repo because i also want it elsewhere
      url = "git+https://github.com/larkin1/config.nvim?shallow=1";
      flake = false;
    };

    config-quickshell = { # quickshell is in active development, so it's in its own repo.
      url = "git+https://github.com/larkin1/config.quickshell?shallow=1";
      flake = false;
    };

    spicetify-nix.url = "git+https://github.com/Gerg-L/spicetify-nix";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      mkHost = { hostname, system ? "x86_64-linux", username ? "larkin" }:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit hostname;
          };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./hosts/${hostname}/conf.nix
            inputs.hjem.nixosModules.default
            inputs.matugen.nixosModules.default
          ];
        };
    in {
      nixosConfigurations = {
        laptop = mkHost { hostname = "laptop"; };
        desktop = mkHost { hostname = "desktop"; };
    };
  };
}
