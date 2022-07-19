{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }:
  let
    system = "x86_64-linux";
    username = "chris";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    lib = nixpkgs.lib;

  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      configuration = import ./users/chris/home.nix;
      inherit system username;
      homeDirectory = "/home/${username}";
      stateVersion = "22.05";
    };
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	modules = [
	  ./system/configuration.nix
	  hyprland.nixosModules.default
	  { programs.hyprland.enable = true; }
	];
      };
    };
  };
}
