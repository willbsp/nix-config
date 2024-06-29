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
    neovim-v0-9-5.url = "github:NixOS/nixpkgs/76ef4c7888c52bd4eed566011c24da9eb437a3c8";
  };
  outputs = { nixpkgs, nix-darwin, neovim-v0-9-5, nixos-hardware, lanzaboote, home-manager, ... }:
    {

      homeConfigurations = {
        "will@prodesk-debian" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
            };
          };
          modules = [ ./home.nix ];
        };
      };

      nixosConfigurations = {
        "framework" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/framework/configuration.nix
            nixos-hardware.nixosModules.framework-11th-gen-intel
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.will = import ./machines/framework/home.nix;
              home-manager.extraSpecialArgs = {
                nvim-pkg = import neovim-v0-9-5 {
                  system = "x86_64-linux";
                };
              };
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
