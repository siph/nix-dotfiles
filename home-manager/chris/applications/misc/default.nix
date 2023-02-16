{ lib, pkgs, ... }:
{
  imports = [
    ./firefox
    ./git
    ./hyprland
    ./ideaVim
    ./jellyfin
    ./kitty
    ./mpv
    ./popcorntime
    ./startx
    ./yt-dlp
  ];
}
