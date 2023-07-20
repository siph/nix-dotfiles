{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "corner" ];
    profiles = {
      corner = {
        ontop = true;
        osc = false;
        ytdl-format = "bestvideo[height<=?1080]+bestaudio";
        cache = true;
        force-seekable = true;
        demuxer-max-bytes = "123400KiB";
        demuxer-readahead-secs = 20;
        script-opts = [
          "ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp"
        ];
      };
    };
    scripts = with pkgs.mpvScripts; [
      quality-menu
      thumbnail
      sponsorblock
    ];
  };
}
