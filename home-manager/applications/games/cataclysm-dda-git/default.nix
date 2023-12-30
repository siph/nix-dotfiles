{pkgs, ...}: {
  home.packages = with pkgs; [
    cataclysm-dda
  ];
}
