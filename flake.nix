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
      url = "git+https://github.com/larkin1/config.ghostty";
      flake = false;
    };
    config-starship = {
      url = "git+https://github.com/larkin1/config.starship";
      flake = false;
    };
    config-hypr = {
      url = "git+https://github.com/larkin1/config.hypr";
      flake = false;
    };
    config-waybar = {
      url = "git+https://github.com/larkin1/config.waybar";
      flake = false;
    };
    config-cava = {
      url = "git+https://github.com/larkin1/config.cava";
      flake = false;
    };
    config-fuzzel = {
      url = "git+https://github.com/larkin1/config.fuzzel";
      flake = false;
    };
    config-nvim = {
      url = "git+https://github.com/larkin1/config.nvim";
      flake = false;
    };
    config-dunst = {
      url = "git+https://github.com/larkin1/config.dunst";
      flake = false;
    };
    config-yazi = {
      url = "git+https://github.com/larkin1/config.yazi";
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
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.larkin = ./home.nix;
            }
          ];
        };
      };
    };
}
