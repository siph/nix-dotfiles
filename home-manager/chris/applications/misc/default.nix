{ lib, pkgs, ... }:
{
  imports = [
    ./firefox
    ./git
    ./ideaVim
    ./kitty
    ./popcorntime
    ./startx
  ];
}
