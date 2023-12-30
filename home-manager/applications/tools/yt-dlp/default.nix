{pkgs, ...}: {
  home.packages = with pkgs; [ffmpeg yt-watcher];
  programs.yt-dlp = {
    enable = true;
    settings = {
      continue = true;
    };
  };
}
