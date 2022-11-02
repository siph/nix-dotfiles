{ lib, pkgs, ... }:
{
  imports = [
    ./bat
    ./bottom
    ./firefox
    ./git
    ./ideaVim
    ./kitty
    ./lsd
    ./shells
    ./starship
    ./startx
    ./tmux
  ];
}
