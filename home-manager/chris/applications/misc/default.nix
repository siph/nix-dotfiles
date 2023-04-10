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
    ./polybar
    ./popcorntime
    ./rofi
    ./startx
    ./xmonad
    ./yt-dlp
  ];
}
