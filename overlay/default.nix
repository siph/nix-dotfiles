{
  chris-neovim,
  lib,
  nixpkgs-stable,
  ollama-flake,
  wt-fetch,
  yt-watcher,
  ...
}: let
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    waybar = prev.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    });

    neovim = chris-neovim.packages.${prev.system}.default;
    yt-watcher = yt-watcher.packages.${prev.system}.default;
    wt-fetch = wt-fetch.packages.${prev.system}.default;

    ollama = ollama-flake.packages.${prev.system}.rocm;

    invidious = prev.invidious.overrideAttrs (_oldAttrs: {
      src = prev.fetchFromGitHub {
        owner = "iv-org";
        repo = "invidious";
        fetchSubmodules = true;
        rev = "08390acd0c17875fddb84cabba54197a5b5740e4";
        sha256 = "sha256-75C/ImX/PYikVdSO4rZM/aYyEgx6pU90BHNeRFfcsDM=";
      };
    });

    # https://github.com/nushell/nu_scripts/pull/669
    # This PR broke my config. I'll figure it out and fix it later™.
    nu_scripts = prev.nu_scripts.overrideAttrs (finalAttrs: previousAttrs: rec {
      version = "99fe279311cf3028930522c0646f9bc70e4451de";

      src = prev.fetchFromGitHub {
        owner = "nushell";
        repo = previousAttrs.pname;
        rev = "${version}";
        hash = "sha256-w1lkdccC3ZzLaUqrQh+QW/H3V23dlhtd+16kkCoOtKI=";
      };
    });

    # nest a stable `nixpkgs` release inside of unstable
    nixpkgs-stable = nixpkgs-stable.legacyPackages.${prev.system};
  };
in
  lib.composeManyExtensions [additions modifications]
