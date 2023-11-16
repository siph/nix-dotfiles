{ lib, chris-neovim, yt-watcher, wt-fetch, nixpkgs-stable, ... }:
let
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    neovim = chris-neovim.packages.${prev.system}.default;
    yt-watcher = yt-watcher.packages.${prev.system}.default;
    wt-fetch = wt-fetch.packages.${prev.system}.default;
    # nest a stable `nixpkgs` release inside of unstable
    nixpkgs-stable = nixpkgs-stable.legacyPackages.${prev.system};
  };
in
lib.composeManyExtensions [ additions modifications ]
