{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    defaultProfiles = ["default"];
    profiles = {
      default = {
        osc = false;
        ao = "pulse";
        cache = true;
        force-seekable = true;
        loop = true;
        script-opts = [
          "ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp"
          # Thumbnails (Press `T` to generate)
          "mpv_thumbnail_script-autogenerate=no"
        ];
      };
    };
    scripts = with pkgs.mpvScripts; [
      thumbnail
      sponsorblock
    ];
  };
}
