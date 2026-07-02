{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Fetch the latest configuration files direct from Github
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
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/laptop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.larkin = ./machines/laptop/home.nix;
            }
          ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.larkin = ./machines/desktop/home.nix;
            }
          ];
        };
        live = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            (nixpkgs + "/nixos/modules/installer/cd-dvd/iso-image.nix")
            ./machines/live/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.larkin = ./machines/live/home.nix;
            }
          ];
        };
    };
  };
}
