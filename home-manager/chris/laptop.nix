{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./applications/terminal
    ./applications/shells
    ./applications/misc/firefox
    ./applications/misc/git
    ./applications/misc/ideaVim
    ./applications/misc/kitty
    ./applications/misc/mpv
    ./applications/misc/yt-dlp
  ];

  home = rec {
    username = "chris";
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      choose
      duf
      fd
      ffmpeg
      glow
      hoard
      httpie
      jetbrains.idea-community
      jq
      ncdu_2
      neovim
      ouch
      procs
      ripgrep
      tdesktop
      tixati
      tldr
      vlc
      xsel
    ];
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
