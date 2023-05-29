{ pkgs, ... }:
{
  imports = [ ./ideaVim ];
  home.packages = with pkgs; [ jetbrains.idea-community ];
}
