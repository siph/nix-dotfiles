# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = false;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    #    wireless.enable = true;
  };

  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
      displayManager.lightdm.enable = true;
      #desktopManager.plasma5.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
    };
  };

  programs = {
    zsh = {
      enable = true;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.chris = {
      isNormalUser = true;
      description = "chris";
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
