{ lib, pkgs, ... }:
{
  imports = [
    ./bash
    ./bat
    ./bottom
    ./firefox
    ./git
    ./ideaVim
    ./lsd
    ./starship
    ./startx
    ./tmux
    ./zsh
  ];
}
