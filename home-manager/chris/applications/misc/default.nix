{ lib, pkgs, ... }:
{
  imports = [
    ./firefox
    ./git
    ./ideaVim
    ./kitty
    ./startx
  ];
}
