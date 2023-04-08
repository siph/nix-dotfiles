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
    ./nix-direnv
    ./popcorntime
    ./startx
    ./yt-dlp
    ./xmonad
  ];
}
