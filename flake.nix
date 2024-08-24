{
  description = "NixOS and nix-darwin configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-dark-mode-nvim = {
      url = "github:f-person/auto-dark-mode.nvim";
      flake = false;
    };
  };
  outputs = { nixpkgs, nixpkgs-unstable, nix-darwin, nixos-hardware, lanzaboote, home-manager, auto-dark-mode-nvim, ... }@inputs:
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
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                (final: prev: {
                  vimPlugins = prev.vimPlugins // {
                    auto-dark-mode = prev.vimUtils.buildVimPlugin {
                      name = "auto-dark-mode-nvim";
                      src = auto-dark-mode-nvim;
                    };
                  };
                  unstable = import nixpkgs-unstable {
                    system = prev.system;
                  };
                })
              ];
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

      homeConfigurations = {
        "will@pi5-ubuntu" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./hm-modules
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
              nixpkgs.overlays = [
                (final: prev: {
                  vimPlugins = prev.vimPlugins // {
                    auto-dark-mode = prev.vimUtils.buildVimPlugin {
                      name = "auto-dark-mode-nvim";
                      src = auto-dark-mode-nvim;
                    };
                  };
                })
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.will.imports = [
                ./hm-modules
                ./machines/macmini/home.nix
              ];
            }
          ];
        };
      };

    };
}
