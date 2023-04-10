{ lib, pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;
    settings = {
      continue = true;
    };
  };
}
