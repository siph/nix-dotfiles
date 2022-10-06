{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "acpi_backlight=vendor"
    ];
  };

  networking = {
    hostName = "media";
    networkmanager.enable = true;
  };

  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
      #"1d2021" # Background
      #"d3869b" # Bright Purple
      #"8f3f71" # Faded Purple
      #"af3a03" # Faded Orange
      #"83a598" # Bright Blue
      #"076678" # Faded Blue
      #"b57614" # Faded Yellow
      #"928374" # Light Grey
      #"fb4934" # Bright Red
      #"9d0006" # Faded Red
      #"b8bb26" # Bright Green
      #"8f3f71" # Faded Green
      #"8ec07c" # Bright Aqua
      #"427b58" # Faded Aqua
      #"928374" # Grey
      #"f9f5d7" # White
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
    jellyfin = {
      enable = true;
      user = "media";
    };
    xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      libinput.enable = true;
      windowManager.dwm.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
    };
    openvpn = {
      servers = {
        dallasVPN = {
          config = '' config /home/media/vpn/vpn.ovpn '';
          autoStart = true;
          updateResolvConf = true;
        };
      };
    };
    logind = {
      lidSwitch = "ignore";
    };
  };

  programs = {
    zsh = {
      enable = true;
    };
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    acpilight.enable = true;
  };

  sound.enable = true;
  security.rtkit.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users.media = {
      isNormalUser = true;
      description = "media";
      extraGroups = ["networkmanager" "wheel" "video"];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    package = pkgs.nixVersions.stable; # or versioned attributes like nixVersions.nix_2_8
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
    dmenu
    feh
    git
    neovim
    xcompmgr
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
