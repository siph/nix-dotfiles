{pkgs, ...}: {
  home.packages = with pkgs; [jellyfin-media-player jellyfin-mpv-shim];

  xdg.dataFile."jellyfinmediaplayer/mpv.conf".source = ./mpv.conf;
}
