{
  description = "Chris' nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chris-neovim.url = "github:siph/nixvim-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yt-watcher = {
      url = "github:siph/yt-watcher";
    };
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nu-scripts = {
      url = "github:nushell/nu_scripts";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    declarative-cachix.url = "github:jonascarpay/declarative-cachix";
  };

  outputs = { nixpkgs, home-manager, nixos-generators, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } ({ withSystem, ... }: rec {

      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = { system, pkgs, self', ... }: {

        # Flake-wide `pkgs` with overlays and custom packages.
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues {
            default = import ./overlay {
              inherit system;
              inherit inputs;
            };
          };
          config = {
            allowUnfree = true;
          };
        };

        devShells = {
          default = with pkgs; mkShell {
            inherit (self'.checks.pre-commit-check) shellHook;
            NIX_CONFIG = "experimental-features = nix-command flakes";
            nativeBuildInputs = [ nix git statix ];
            programs = [ home-manager ];
          };
        };

        formatter = pkgs.nixpkgs-fmt;

        checks = {
          pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
              statix.enable = true;
            };
          };
        };
      };

      flake = rec {
        nixosModules = import ./modules/nixos;
        homeManagerModules = import ./modules/home-manager;

        nixosConfigurations = {
          nixos = withSystem "x86_64-linux" ({ pkgs, ... }:
            inputs.nixpkgs.lib.nixosSystem {
              inherit pkgs;
              specialArgs = { inherit inputs; };
              modules = (builtins.attrValues nixosModules) ++ [
                ./nixos/desktop
                inputs.musnix.nixosModules.musnix
              ];
            });

          raspberry-pi = withSystem "aarch64-linux" ({ pkgs, ... }:
            inputs.nixpkgs.lib.nixosSystem {
              inherit pkgs;
              specialArgs = { inherit inputs; };
              modules = (builtins.attrValues nixosModules) ++ [
                ./nixos/raspberry-pi
              ];
            });
        };

        homeConfigurations = {
          "chris@nixos" = withSystem "x86_64-linux" ({ pkgs, ... }:
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs; };
              modules = (builtins.attrValues homeManagerModules) ++ [
                ./home-manager/chris
              ];
            });

          "chris@kubuntu-laptop" = withSystem "x86_64-linux" ({ pkgs, ... }:
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs; };
              modules = (builtins.attrValues homeManagerModules) ++ [
                ./home-manager/chris/laptop.nix
              ];
            });

          "chris@raspberry-pi" = withSystem "aarch64-linux" ({ pkgs, ... }:
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = { inherit inputs; };
              modules = (builtins.attrValues homeManagerModules) ++ [
                ./home-manager/chris/raspberry-pi.nix
              ];
            });
        };
      };
    });
}
