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
    config-ghostty = {
      url = "git+https://github.com/larkin1/config.ghostty?shallow=1";
      flake = false;
    };
    config-starship = {
      url = "git+https://github.com/larkin1/config.starship?shallow=1";
      flake = false;
    };
    config-hypr = {
      url = "git+https://github.com/larkin1/config.hypr?shallow=1";
      flake = false;
    };
    config-waybar = {
      url = "git+https://github.com/larkin1/config.waybar?shallow=1";
      flake = false;
    };
    config-cava = {
      url = "git+https://github.com/larkin1/config.cava?shallow=1";
      flake = false;
    };
    config-fuzzel = {
      url = "git+https://github.com/larkin1/config.fuzzel?shallow=1";
      flake = false;
    };
    config-nvim = {
      url = "git+https://github.com/larkin1/config.nvim?shallow=1";
      flake = false;
    };
    config-dunst = {
      url = "git+https://github.com/larkin1/config.dunst?shallow=1";
      flake = false;
    };
    config-yazi = {
      url = "git+https://github.com/larkin1/config.yazi?shallow=1";
      flake = false;
    };
    config-walls = {
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
          inherit system;
          modules = [
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
