{ pkgs, ... }:
{
  home.packages = with pkgs; [ vlc ];
  imports = [
    ./jellyfin
    ./kodi
    ./mpv
    ./popcorntime
  ];
}
