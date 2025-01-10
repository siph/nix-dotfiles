{pkgs, ...}: {
  imports = [
    ../applications
  ];

  home = rec {
    username = "chris";
    homeDirectory = "/home/${username}";
    sessionPath = ["/home/${username}/.local/bin"];
    stateVersion = "23.05";
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  fonts.fontconfig.enable = true;
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
