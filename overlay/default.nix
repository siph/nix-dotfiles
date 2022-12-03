# This file defines two overlays and composes them
{  inputs, pkgs, ... }:
let
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    dwm = prev.dwm.overrideAttrs (oldAttrs: rec {
      src = pkgs.fetchFromGitLab {
        owner = "xsiph";
        repo = "dwm";
        rev = "6d27f8a235150a234b5158908406af294b31cf55";
        sha256 = "0oXZj+mHUPcCCniWk6uwIcvfpRQcKT05CAlk1KsnMAo=";
      };
    });
    neovim = inputs.chris-neovim.packages.x86_64-linux.default;
    starship = prev.starship.overrideAttrs (oldAttrs: rec {
      src = pkgs.fetchFromGitHub {
        owner = "starship";
        repo = "starship";
        rev = "ef83e7a0928231b02650b3554ccd5bf21164aaff";
        sha256 = "rwnlO6dtRT09+nMxAlqz5X7s5q/uVd5plg2fxvRrI6g=";
      };
      cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
        inherit src;
        name = "starship-ef83e7a0928231b02650b3554ccd5bf21164aaff-vendor.tar.gz";
        outputHash = "sha256-kBlkyRxGQz76a1IwvXNTAqIEWxMDTMwAhBtJV+beizM=";
    });
    });
    #inherit (inputs.veloren.packages."x86_64-linux") veloren-voxygen;
  };
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
