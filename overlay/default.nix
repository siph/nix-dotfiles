{ inputs, ... }:
let
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    neovim = inputs.chris-neovim.packages.${prev.system}.default;
    yt-watcher = inputs.yt-watcher.packages.${prev.system}.default;
    wt-fetch = inputs.wt-fetch.packages.${prev.system}.default;
    nushell = prev.nushell.overrideAttrs (oldAttrs: rec {
      version = "0.85.0";
      src = inputs.nixpkgs.legacyPackages.${prev.system}.fetchFromGitHub {
        inherit version;
        owner = "nushell";
        repo = "nushell";
        rev = "a6f62e05ae5b4e9ba4027fbfffd21025a898783e";
        sha256 = "sha256-/c3JTgIT+T41D0S7irQ0jq2MDzmx3os4pYpVr10cL3E=";
      };
      cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
        inherit src;
        name = "${oldAttrs.pname}-${src.rev}-vendor.tar.gz";
        outputHash = "sha256-WSH9GpnjmVijjNBph0BcTvZXMS/dZ8P0x4jA4Nt2SlI=";
      });
    });
    # nest a stable `nixpkgs` release inside of unstable
    nixpkgs-stable = inputs.nixpkgs-stable.legacyPackages.${prev.system};
  };
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
