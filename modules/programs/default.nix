{ lib, pkgs, ... }:
{
  imports = [
    ./bash
    ./bat
    ./bottom
    ./firefox
    ./git
    ./lsd
    ./starship
    ./tmux
    ./zsh
  ];
}
