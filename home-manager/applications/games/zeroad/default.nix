{pkgs, ...}: {
  home.packages = with pkgs; [zeroadPackages.zeroad-unwrapped];
}
