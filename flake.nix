{
  description = "NixOS and nix-darwin configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager"; # unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad = {
      url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, nix-darwin, nixos-hardware, lanzaboote, home-manager, kmonad, ... }@inputs:
    {

      nixosConfigurations = {
        "framework" = nixpkgs.lib.nixosSystem {
          # laptop
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./machines/framework/configuration.nix
            ./nixos-modules
            nixos-hardware.nixosModules.framework-11th-gen-intel
            lanzaboote.nixosModules.lanzaboote
            kmonad.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.will.imports = [
                ./hm-modules
                ./machines/framework/home.nix
              ];
            }
          ];
        };
        "hal" = nixpkgs.lib.nixosSystem {
          # home server
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./machines/hal/configuration.nix
            ./nixos-modules
            nixos-hardware.nixosModules.common-cpu-intel-cpu-only
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.will.imports = [
                ./hm-modules
                ./machines/hal/home.nix
              ];
            }
          ];
        };
        "glados" = nixpkgs.lib.nixosSystem {
          # gaming pc
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./machines/glados/configuration.nix
            ./nixos-modules
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.will.imports = [ ./hm-modules ];
            }
          ];
        };
      };

      darwinConfigurations = {
        "macmini" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./machines/macmini/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.will = import ./machines/macmini/home.nix;
            }
          ];
        };
      };

    };
}
