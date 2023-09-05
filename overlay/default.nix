{ inputs, ... }:
let
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    neovim = inputs.chris-neovim.packages.${prev.system}.default;
    yt-watcher = inputs.yt-watcher.packages.${prev.system}.default;
    # nest a stable `nixpkgs` release inside of unstable
    nixpkgs-stable = inputs.nixpkgs-stable.legacyPackages.${prev.system};
  };
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications ]
