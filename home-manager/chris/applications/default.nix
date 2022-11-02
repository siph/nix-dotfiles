{ lib, pkgs, ... }:
{
  imports = [
    ./bash
    ./bat
    ./bottom
    ./firefox
    ./git
    ./ideaVim
    ./kitty
    ./lsd
    ./starship
    ./startx
    ./tmux
    ./zsh
  ];
}
