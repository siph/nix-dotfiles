{ pkgs }: {

  bar-clock = pkgs.callPackage ./bar/bar-clock { };
  bar-weather = pkgs.callPackage ./bar/bar-weather { };
  bar-gh-inbox = pkgs.callPackage ./bar/bar-gh-inbox { };

  startx-xmonad = pkgs.callPackage ./start-scripts/xmonad { };
  startx-kde = pkgs.callPackage ./start-scripts/kde { };
  start-hyprland = pkgs.callPackage ./start-scripts/hyprland { };
  startx-qtile = pkgs.callPackage ./start-scripts/qtile { };
}
