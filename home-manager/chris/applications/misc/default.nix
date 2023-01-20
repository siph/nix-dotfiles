{ lib, pkgs, ... }:
{
  imports = [
    ./firefox
    ./git
    ./ideaVim
    ./jellyfin
    ./kitty
    ./popcorntime
    ./startx
  ];
}
