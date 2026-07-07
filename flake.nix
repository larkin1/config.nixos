{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";


    # --- Special Apps ---
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # --- Configurations ---
    config-nvim = { # i keep my nvim config in a separate repo because i also want it elsewhere
      url = "git+https://github.com/larkin1/config.nvim?shallow=1";
      flake = false;
    };
    config-walls = { # i keep my walls in a separate repo to keep the size of this repo relatively low
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
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./machines/${hostname}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.${username} = ./machines/${hostname}/home.nix;
            }
          ];
        };
    in {
      nixosConfigurations = {
        laptop = mkHost { hostname = "laptop"; };
        desktop = mkHost { hostname = "desktop"; };
        work = mkHost { hostname = "work"; };
    };
  };
}
