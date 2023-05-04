{
  description = "Chris' nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chris-neovim.url = "github:siph/neovim-flake";
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
    mywm = {
      url = "github:siph/mywm";
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
    in
    rec {
      overlays = {
        default = import ./overlay {
          inherit inputs;
          pkgs = legacyPackages.x86_64-linux;
        };
      };

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.callPackage ./shell.nix { };
      });

      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;

          # NOTE: Using `nixpkgs.config` in your NixOS config won't work
          # Instead, you should set nixpkgs configs here
          # (https://nixos.org/manual/nixpkgs/stable/#idm140737322551056)
          config.allowUnfree = true;
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
      };

      packages.x86_64-linux = {
        iso = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          format = "iso";
        };
      };
    };
}
