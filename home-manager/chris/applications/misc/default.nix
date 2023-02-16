{ lib, pkgs, ... }:
{
  imports = [
    ./firefox
    ./git
    ./ideaVim
    ./jellyfin
    ./kitty
    ./mpv
    ./popcorntime
    ./startx
    ./yt-dlp
  ];
}
