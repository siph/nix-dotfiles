# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  networking = {
    hostName = "raspberry-pi";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Denver";

  console = {
    earlySetup = true;
    colors = [
      "1d2021" # Background
      "d3869b" # Bright Purple
      "8f3f71" # Faded Purple
      "af3a03" # Faded Orange
      "83a598" # Bright Blue
      "076678" # Faded Blue
      "b57614" # Faded Yellow
      "928374" # Light Grey
      "fb4934" # Bright Red
      "9d0006" # Faded Red
      "b8bb26" # Bright Green
      "8f3f71" # Faded Green
      "8ec07c" # Bright Aqua
      "427b58" # Faded Aqua
      "928374" # Grey
      "f9f5d7" # White
    ];
    packages = with pkgs; [
      terminus_font
      powerline-fonts
    ];
    font = "ter-powerline-v14b";
  };

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
      displayManager.startx.enable = true;
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
  };

  programs = {
    zsh = {
      enable = true;
    };
  };

  users = {
    defaultUserShell = pkgs.nushell;
    users.chris = {
      # assword
      initialHashedPassword = "$y$j9T$.vGKpuK.CMO92lCpcofCe.$czTQRFe/gke1R8YBuWIrgLWVF4y7Z.qLYVUWfUpUrw7";
      isNormalUser = true;
      description = "chris";
      extraGroups = [ "networkmanager" "wheel" "network" ];
    };
  };

  environment.systemPackages = with pkgs; [
    tmux
    bottom
    wget
    git
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

