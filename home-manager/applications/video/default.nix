{pkgs, ...}: {
  home.packages = with pkgs; [vlc];
  imports = [
    ./jellyfin
    ./kdenlive
    ./kodi
    ./mpv
    ./popcorntime
  ];
}
