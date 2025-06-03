{
  description = "Chris' nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-minima = {
      url = "github:rockofox/firefox-minima";
      flake = false;
    };
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty-flake.url = "github:ghostty-org/ghostty";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    chris-neovim.url = "github:siph/nixvim-flake";
    wt-fetch.url = "github:siph/wt-fetch";
    yt-watcher.url = "github:siph/yt-watcher";
  };

  outputs = {
    chris-neovim,
    firefox-minima,
    flake-parts,
    ghostty-flake,
    home-manager,
    musnix,
    nixos-cosmic,
    nixos-generators,
    nixpkgs,
    nixpkgs-stable,
    pre-commit-hooks,
    treefmt-nix,
    wt-fetch,
    yt-watcher,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      imports = [
        treefmt-nix.flakeModule
      ];

      perSystem = {
        system,
        config,
        pkgs,
        lib,
        self',
        ...
      }: let
        treefmtWrapper = config.treefmt.build.wrapper;
      in {
        # Flake-wide `pkgs` with overlays and custom packages.
        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = builtins.attrValues {
            default = import ./overlay {
              inherit chris-neovim firefox-minima ghostty-flake lib nixpkgs-stable wt-fetch yt-watcher;
            };
          };
          config = {
            allowUnfreePredicate = pkg:
              builtins.elem (lib.getName pkg) [
                "steam"
                "steam-original"
                "steam-run"
                "steam-unwrapped"
                "starsector"
                "surrealdb"
                "nxengine-evo"
              ];
            permittedInsecurePackages = [
              "openssl-1.1.1v"
            ];
          };
        };

        devShells = {
          default = with pkgs;
            mkShell {
              inherit (self'.checks.pre-commit-check) shellHook;
              NIX_CONFIG = "experimental-features = nix-command flakes";
              # WARNING: Please! Stop deleting the `pkgs` from `home-manager` and
              # then being confused about the devshell breaking. `home-manager`
              # is shadowed by the input.
              nativeBuildInputs = [nix git statix pkgs.home-manager treefmtWrapper];
            };
        };

        treefmt = {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            black.enable = true;
            prettier.enable = true;
            # shellcheck.enable = true;
            # stylish-haskell.enable = true;
          };
        };

        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              treefmt.enable = true;
              treefmt.package = treefmtWrapper;
            };
          };
        };
      };

      flake = rec {
        nixosModules = import ./modules/nixos;
        homeManagerModules = import ./modules/home-manager;

        nixosConfigurations = {
          nixos = withSystem "x86_64-linux" ({pkgs, ...}:
            inputs.nixpkgs.lib.nixosSystem {
              inherit pkgs;
              specialArgs = {inherit inputs;};
              modules =
                (builtins.attrValues nixosModules)
                ++ [
                  ./nixos/desktop
                  musnix.nixosModules.musnix
                  nixos-cosmic.nixosModules.default
                ];
            });
        };

        homeConfigurations = {
          "chris@nixos" = withSystem "x86_64-linux" ({pkgs, ...}:
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = {inherit inputs;};
              modules =
                (builtins.attrValues homeManagerModules)
                ++ [
                  ./home-manager/chris
                ];
            });

          "chris@kubuntu-laptop" = withSystem "x86_64-linux" ({pkgs, ...}:
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              extraSpecialArgs = {inherit inputs;};
              modules =
                (builtins.attrValues homeManagerModules)
                ++ [
                  ./home-manager/chris/laptop.nix
                ];
            });
        };
      };
    });
}
