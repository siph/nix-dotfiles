{ pkgs, ... }:
{
  home.packages = with pkgs; [ vlc ];
  imports = [
    ./jellyfin
    ./mpv
    ./popcorntime
  ];
}
