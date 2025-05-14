{pkgs, ...}: {
  home.packages = with pkgs; [vlc];
  imports = [
    ./freetube
    ./jellyfin
    ./kodi
    ./mpv
    # ./popcorntime
  ];
}
