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
  };
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
