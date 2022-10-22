{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/programs
  ];
  home = rec {
    username = "chris";
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      ardour
      ark
      bluetuith
      broot
      cargo
      choose
      doctl
      duf
      fd
      ffmpeg
      gh
      glow
      hoard
      httpie
      jetbrains.idea-ultimate
      jq
      kubectl
      minikube
      mpv
      ncdu_2
      neofetch
      nixpkgs-review
      ouch
      procs
      ripgrep
      rustc
      steam
      tdesktop
      tixati
      tldr
      unzip
      vlc
      xsel
      yt-dlp
    ];
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
