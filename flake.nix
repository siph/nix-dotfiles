{
  description = "Chris' nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chris-neovim.url = "github:siph/nixvim-flake";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    declarative-cachix.url = "github:jonascarpay/declarative-cachix";
  };

  outputs = { nixpkgs, home-manager, nixos-generators, hyprland, yt-watcher, ... }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in rec {

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.callPackage ./shell.nix { };
      });

      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
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
        }
      );

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages.x86_64-linux;
          specialArgs = { inherit inputs; };
          modules = (builtins.attrValues nixosModules) ++ [
            ./nixos/desktop
            hyprland.nixosModules.default
          ];
        };
        raspberry-pi = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages.aarch64-linux;
          specialArgs = { inherit inputs; };
          modules = (builtins.attrValues nixosModules) ++ [
            ./nixos/raspberry-pi
            hyprland.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        "chris@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = (builtins.attrValues homeManagerModules) ++ [
            ./home-manager/chris
          ];
        };
        "chris@kubuntu-laptop" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = (builtins.attrValues homeManagerModules) ++ [
            ./home-manager/chris/laptop.nix
          ];
        };
        "chris@raspberry-pi" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.aarch64-linux;
          extraSpecialArgs = { inherit inputs; };
          modules = (builtins.attrValues homeManagerModules) ++ [
            ./home-manager/chris/raspberry-pi.nix
          ];
        };
      };

      packages = {
        x86_64-linux.iso = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "iso";
        };
        # I have tried at least 5 different way and I cannot get
        # `nixosGenerate` to use the overlays in `nixpkgs`.
        aarch64-linux.raspberry-pi = nixos-generators.nixosGenerate {
          format = "sd-aarch64";
          pkgs = legacyPackages.aarch64-linux;
          modules = (builtins.attrValues nixosModules) ++ [
            ./nixos/raspberry-pi
            home-manager.nixosModules.home-manager
            {
              home-manager.users.chris = {
                imports = [ ./home-manager/chris/raspberry-pi.nix ];
              };
            }
          ];
        };
      };
    };
}
