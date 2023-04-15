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
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    starship = prev.starship.overrideAttrs (oldAttrs: rec {
      src = pkgs.fetchFromGitHub {
        owner = "starship";
        repo = "starship";
        rev = "07d9bb1691cf42c354a4feb3affd977b97e5b937";
        sha256 = "sha256-jDvtUwPtBuQOXvecE8jPSIT2hsov6DybpeTjk3dH6Bc=";
      };
      cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
        inherit src;
        name = "starship-07d9bb1691cf42c354a4feb3affd977b97e5b937-vendor.tar.gz";
        outputHash = "sha256-jf+lb9rZTjdqRLpC+hN8M/+DgNMCoLCmb4CyqjYbvtM=";
      });
    });
    neovim = inputs.chris-neovim.packages.x86_64-linux.default;
    #inherit (inputs.veloren.packages."x86_64-linux") veloren-voxygen;
    yt-watcher = inputs.yt-watcher.packages.x86_64-linux.default;
  };
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
