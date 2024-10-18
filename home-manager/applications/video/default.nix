{pkgs, ...}: {
  home.packages = with pkgs; [vlc];
  imports = [
    ./freetube
    ./jellyfin
    ./kdenlive
    ./kodi
    ./mpv
    # ./popcorntime
  ];
}
