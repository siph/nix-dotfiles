{ pkgs, ... }: {
  imports = [
    ./applications/terminal-emulators/kitty
    ./applications/shells
    ./applications/tools
    ./applications/browsers
    ./applications/editors
    ./applications/video
  ];

  home = rec {
    username = "chris";
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
