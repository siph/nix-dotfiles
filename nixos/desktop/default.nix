{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  musnix = {
    enable = true;
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";

      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      substituters = [
        "https://nix-community.cachix.org"
        "https://surrealdb.cachix.org"
        "https://ghostty.cachix.org"
        "https://cosmic.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "surrealdb.cachix.org-1:rbm7Qs+s36pxbfk9jhIa5HRld6gZ63koZz1h/9sSxaA="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [3000 8000 8081 8080 1313];
  };

  boot = {
    loader.systemd-boot.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = ["aarch64-linux"];
  };

  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";
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
    gnome.gnome-keyring.enable = true;

    xserver = {
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      windowManager.qtile = {
        enable = true;
        package = pkgs.qtile-unwrapped;
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
      };
    };

    openvpn = {
      servers = {
        dallasVPN = {
          config = ''config /home/chris/vpn/vpn.ovpn '';
          autoStart = false;
          updateResolvConf = true;
        };
      };
    };

    ollama.enable = true;

    open-webui = {
      enable = false;
      port = 8082;
    };

    transmission = {
      enable = false;
      settings = {
        downloadDirPermissions = "770";
        incomplete-dir-enable = false;
        umask = 0;
      };
    };

    i2pd = {
      enable = true;
      proto = {
        http.enable = true;
        httpProxy.enable = true;
        sam.enable = true;
      };
    };

    invidious = {
      enable = true;
      settings.db.user = "invidious";
    };

    pcscd.enable = true;

    desktopManager.cosmic.enable = false;
    displayManager.cosmic-greeter.enable = false;
  };

  environment.systemPackages = with pkgs; [pinentry-curses wget];

  programs = {
    kdeconnect.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    dconf.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;

    bluetooth.enable = true;

    graphics = {
      enable = true;
      # 32 Bit Libraries for Steam
      enable32Bit = true;
    };
  };

  virtualisation.docker.enable = true;

  users = {
    defaultUserShell = pkgs.nushell;

    users.chris = {
      isNormalUser = true;
      description = "chris";
      extraGroups = ["networkmanager" "wheel" "docker" "audio" "transmission"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
