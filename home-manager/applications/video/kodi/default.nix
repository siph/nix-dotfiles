{ pkgs, ... }:
{
  programs.kodi = {
    enable = true;
    package = pkgs.kodi.withPackages (exts: with exts; [
      jellyfin
      pvr-iptvsimple
      youtube
    ]);
  };
}
