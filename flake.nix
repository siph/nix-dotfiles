{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }: 
  let 
    system = "x86_64-linux";
    username = "chris";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      configuration = import ./users/chris/home.nix;
      inherit system username;
      homeDirectory = "/home/${username}";
      stateVersion = "22.05";
    };
#    homeManagerConfigurations = {
#      chris = home-manager.lib.homeManagerConfiguration {
#	inherit system pkgs;
#	username = "chris";
#	homeDirectory = "/home/chris";
#	configuration = {
#	  imports = [
#	    ./users/chris/home.nix
#	  ];
#	};
#      };
#    };
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	modules = [
	  ./system/configuration.nix
	];
      };
    };
  };
}
