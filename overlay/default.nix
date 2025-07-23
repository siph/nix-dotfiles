{
  chris-neovim,
  firefox-minima,
  ghostty-flake,
  lib,
  nixpkgs-stable,
  wt-fetch,
  yt-watcher,
  ...
}: let
  additions = final: _prev:
    import ../pkgs {
      pkgs = final;
      ff-minima = firefox-minima;
    };

  modifications = final: prev: {
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });

    neovim = chris-neovim.packages.${prev.system}.default;
    yt-watcher = yt-watcher.packages.${prev.system}.default;
    wt-fetch = wt-fetch.packages.${prev.system}.default;

    ghostty = ghostty-flake.packages.${prev.system}.default;

    # nest a stable `nixpkgs` release inside of unstable
    nixpkgs-stable = nixpkgs-stable.legacyPackages.${prev.system};
  };
in
  lib.composeManyExtensions [additions modifications]
