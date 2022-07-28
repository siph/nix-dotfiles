{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot = {
    enable = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    #wireless.enable = true;
  };

  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.plasma5.enable = true;
      windowManager.dwm.enable = true;
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

  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
  };

  sound.enable = true;
  security.rtkit.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.chris = {
      isNormalUser = true;
      description = "chris";
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    (dwm.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitLab {
        owner = "xsiph";
        repo = "dwm";
        rev = "6d27f8a235150a234b5158908406af294b31cf55";
        sha256 = "0oXZj+mHUPcCCniWk6uwIcvfpRQcKT05CAlk1KsnMAo=";
      };
    }))
    openvpn
    dmenu
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
