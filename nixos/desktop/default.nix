{ inputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware), use something like:
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # It's strongly recommended you take a look at
    # https://github.com/nixos/nixos-hardware
    # and import modules relevant to your hardware.

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ./cachix
  ];

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  boot = {
    loader.systemd-boot.enable = true;
    kernelParams = [
      "radeon.si_support=0"
      "amdgpu.si_support=1"
      "radeon.cik_support=0"
      "amdgpu.cik_support=1"
    ];
    # kernelPackages = pkgs.linuxPackages-rt_latest;
    kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = [ "aarch64-linux" ];
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

  musnix = {
    enable = true;
  };

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
      displayManager = {
        startx.enable = true;
      };
      windowManager.qtile = {
        enable = true;
        package = pkgs.qtile;
      };
      desktopManager.plasma5.enable = true;
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
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
    openvpn = {
      servers = {
        dallasVPN = {
          config = '' config /home/chris/vpn/vpn.ovpn '';
          autoStart = false;
          updateResolvConf = true;
        };
      };
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
    };
    pcscd.enable = true;
  };

  environment.systemPackages = with pkgs; [ pinentry-curses wget ];

  programs = {
    zsh = {
      enable = true;
    };
    kdeconnect.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "curses";
    };
    dconf.enable = true;
    hyprland = {
      enable = false;
    };
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    opengl = {
      enable = true;
      # 32 Bit Libraries for Steam
      driSupport32Bit = true;
    };
  };

  virtualisation.docker.enable = true;

  sound.enable = true;

  users = {
    defaultUserShell = pkgs.nushell;
    users.chris = {
      isNormalUser = true;
      description = "chris";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [ "networkmanager" "wheel" "docker" "audio" "transmission" ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
