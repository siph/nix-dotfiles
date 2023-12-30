{pkgs, ...}: {
  home.packages = with pkgs; [startx-qtile];
}
