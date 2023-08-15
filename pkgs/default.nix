# When you add custom packages, list them here
# These are similar to nixpkgs packages
{ pkgs }: {
  # example = pkgs.callPackage ./example { };
  startx-xmonad = pkgs.callPackage ./start-scripts/xmonad { };
  startx-kde = pkgs.callPackage ./start-scripts/kde { };
  start-hyprland = pkgs.callPackage ./start-scripts/hyprland { };
}
