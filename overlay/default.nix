# This file defines two overlays and composes them
{ inputs, system, ... }:
let
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    neovim = inputs.chris-neovim.packages.${system}.default;
    yt-watcher = inputs.yt-watcher.packages.${system}.default;
    nushell = prev.nushell.overrideAttrs (oldAttrs: rec {
      src = inputs.nixpkgs.legacyPackages.${system}.fetchFromGitHub {
        owner = "nushell";
        repo = "nushell";
        version = "0.84.0";
        rev = "d2abb8603abab43ec4a6d4ed56f9018790b99dce";
        sha256 = "sha256-vXtQUWKRPS53IBUgO9Dw8dVzfD5W2kHSPOZHs293O5Q=";
      };
      cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
        inherit src;
        name = "nushell-d2abb8603abab43ec4a6d4ed56f9018790b99dce-vendor.tar.gz";
        outputHash = "sha256-BTK7qJjwvtpQek3BF7IIekkH1e1lamFh5BvpPj7wA84=";
      });
    });
  };
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
