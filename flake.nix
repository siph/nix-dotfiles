{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    lib = nixpkgs.lib;
  in {
    homeConfigurations = {
      chris = home-manager.lib.homeManagerConfiguration rec {
        inherit system;
        username = "chris";
        configuration = import ./users/${username}/home.nix;
        homeDirectory = "/home/${username}";
        stateVersion = "22.05";
      };
      media = home-manager.lib.homeManagerConfiguration rec {
        inherit system;
        username = "media";
        configuration = import ./users/${username}/home.nix;
        homeDirectory = "/home/${username}";
        stateVersion = "22.05";
      };
    };
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/nixos/configuration.nix
        ];
      };
      media = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/media/configuration.nix
        ];
      };
    };
  };
}
