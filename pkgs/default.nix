{
  pkgs,
  ff-minima,
}:
with pkgs; {
  bar-clock = callPackage ./bar/bar-clock {};
  bar-weather = callPackage ./bar/bar-weather {};
  bar-gh-inbox = callPackage ./bar/bar-gh-inbox {};

  # kdeconnectd = pkgs.callPackage ./bar/kdeconnectd {};

  startx-xmonad = callPackage ./start-scripts/xmonad {};
  startx-kde = callPackage ./start-scripts/kde {};
  startx-qtile = callPackage ./start-scripts/qtile {};

  firefox-minima = callPackage ./themes/firefox-minima.nix {inherit ff-minima;};
}
