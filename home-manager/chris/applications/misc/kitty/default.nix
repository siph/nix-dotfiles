{ lib, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Dark Hard";
    font = {
      name = "JetBrains Mono NL ExtraBold Nerd Font Complete";
      size = 9;
    };
    settings = {
      enable_audio_bell = false;
      visual_bell_duration = 0;
      window_alert_on_bell = false;
      background_opacity = "0.85";
      confirm_os_window_close = 0;
    };
  };
}
