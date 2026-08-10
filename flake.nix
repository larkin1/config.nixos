{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # --- Special Apps ---
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ytm-player = {
      url = "github:peternaame-boop/ytm-player";
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

    config-walls = { # i keep my walls in a separate repo to keep the size of this repo lower
      url = "git+https://github.com/larkin1/config.walls?shallow=1";
      flake = false;
    };

    spicetify-nix.url = "git+https://github.com/Gerg-L/spicetify-nix";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
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
          ];
        };
    in {
      nixosConfigurations = {
        laptop = mkHost { hostname = "laptop"; }; # uses home manager
        desktop = mkHost { hostname = "desktop"; }; # uses home manager
    };
  };
}
