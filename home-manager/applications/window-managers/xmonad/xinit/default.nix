{pkgs, ...}: {
  home.packages = with pkgs; [startx-xmonad];
}
