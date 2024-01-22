{pkgs, ...}: {
  programs.kodi = {
    enable = false;
    package = pkgs.kodi.withPackages (exts:
      with exts; [
        jellyfin
        pvr-iptvsimple
        youtube
      ]);
  };
}
