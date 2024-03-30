{pkgs, ...}: {
  home.packages = with pkgs; [ffmpeg yt-watcher];

  programs.yt-dlp = {
    enable = true;
    settings = {
      continue = true;
    };
  };

  systemd.user.services.yt-watcher = with pkgs; {
    Unit.Description = "Youtube auto-downloader";

    Install.WantedBy = ["default.target"];

    Service.ExecStart = ''
      ${pkgs.yt-watcher}/bin/yt-watcher /home/chris/.config/yt-watcher/config.yaml
    '';
  };
}
