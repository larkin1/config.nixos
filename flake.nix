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

    sops-nix = {
      url = "git+https://github.com/Mic92/sops-nix?shallow=1";
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

    spicetify-nix.url = "git+https://github.com/Gerg-L/spicetify-nix?shallow=1";

    # --- Server ---
    microvm = {
      url = "git+https://github.com/astro/microvm.nix?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, microvm, ... }:
    let
      mkHost = { hostname, system ? "x86_64-linux", username ? "larkin" }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs username hostname; };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./hosts/${hostname}/conf.nix
            inputs.hjem.nixosModules.default
            inputs.matugen.nixosModules.default
            inputs.sops-nix.nixosModules.default
          ];
        };

      mkServer = { hostname, username ? "larkin"}:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs hostname username; };
          modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            ./hosts/${hostname}/conf.nix
            microvm.nixosModules.microvm
            inputs.sops-nix.nixosModules.default
          ];
        };

      mkHypervisor = { hostname, username ? "larkin"}:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs hostname username; };
          modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            ./hosts/${hostname}/conf.nix
            inputs.sops-nix.nixosModules.default
          ];
        };
    in {
      nixosConfigurations = {
        laptop = mkHost { hostname = "laptop"; };
        desktop = mkHost { hostname = "desktop"; };

        typhon = mkHypervisor { hostname = "typhon"; };

        pegasus = mkServer { hostname = "pegasus"; };
        chiron = mkServer { hostname = "chiron"; };
        tartarus = mkServer { hostname = "tartarus"; };
    };
  };
}
