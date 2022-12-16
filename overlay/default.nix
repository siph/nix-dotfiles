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
    glow =
        let
          version = "3c36258be77d6c636040e7d37b600a2daa2d168b";
          src = pkgs.fetchFromGitHub {
            owner = "WieeRd";
            repo = "glow";
            rev = "3c36258be77d6c636040e7d37b600a2daa2d168b";
            sha256 = "x6NEboTGqp3OwCjm2fcm6MUEhcIOuai1Qvl3s0Totr4=";
          };
        in
          (pkgs.callPackage "${pkgs.path}/pkgs/applications/editors/glow" {
            buildGoModule = args: pkgs.buildGoModule (args // {
              vendorSha256 = "JCqC494VN60ij65G2+4PRoQJib+fRV+kiOWgSO45e7M=";
              inherit src version;
            });
          });
    neovim = inputs.chris-neovim.packages.x86_64-linux.default;
    #inherit (inputs.veloren.packages."x86_64-linux") veloren-voxygen;
  };
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
