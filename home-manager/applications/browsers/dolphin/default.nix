{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.dolphin
  ];
}
