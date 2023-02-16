{ lib, pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;
    settings = {
      continue = true;
        format = "bestvideo[height<=?1080]+bestaudio";
    };
  };
}
