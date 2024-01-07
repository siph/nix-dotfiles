{pkgs, ...}: {
  home.packages = with pkgs; [jellyfin-media-player];

  xdg.dataFile."jellyfinmediaplayer/mpv.conf".source = ./mpv.conf;
}
