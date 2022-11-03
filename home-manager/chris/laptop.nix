{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./applications/bat
    ./applications/bottom
    ./applications/broot
    ./applications/firefox
    ./applications/git
    ./applications/ideaVim
    ./applications/kitty
    ./applications/lsd
    ./applications/shells
    ./applications/starship
    ./applications/tmux
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
      jetbrains.idea-ultimate
      jq
      mpv
      ncdu_2
      neofetch
      neovim
      ouch
      procs
      ripgrep
      tdesktop
      tixati
      tldr
      vlc
      xsel
      yt-dlp
    ];
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
