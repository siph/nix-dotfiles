{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "corner" ];
    profiles = {
      corner = {
        ontop = true;
        osc = false;
        ao = "pulse";
        ytdl-format = "bestvideo[height<=?1080]+bestaudio";
        cache = true;
        force-seekable = true;
        script-opts = [
          "ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp"
          # Thumbnails (Press `T` to generate)
          "mpv_thumbnail_script-autogenerate=no"
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
