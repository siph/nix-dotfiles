{pkgs, ...}: {
  home.packages = [pkgs.ghostty];

  xdg.configFile."ghostty/config".source = ./config;
}
