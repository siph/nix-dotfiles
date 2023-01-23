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
        version = "19732a63035e316e3079d15030a573e89d7115cf";
        src = pkgs.fetchFromGitHub {
          owner = "charmbracelet";
          repo = "glow";
          rev = "${version}";
          sha256 = "sha256-CI0S9XJtJQClpQvI6iSb5rcHafEUwr2V6+Fq560lRfM=";
        };
      in
        (pkgs.callPackage "${pkgs.path}/pkgs/applications/editors/glow" {
          buildGoModule = args: pkgs.buildGoModule (args // {
            vendorSha256 = "sha256-2QrHBbhJ04r/vPK2m8J2KZSFrREDCc18tlKd7evghBc=";
            inherit src version;
          });
    });
    neovim = inputs.chris-neovim.packages.x86_64-linux.default;
    #inherit (inputs.veloren.packages."x86_64-linux") veloren-voxygen;
  };
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
