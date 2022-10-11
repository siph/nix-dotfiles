{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  imports = [
    ../../modules/programs/git
    ../../modules/programs/zsh
    ../../modules/programs/tmux
    ../../modules/programs/bottom
    ../../modules/programs/starship
    ../../modules/programs/lsd
    ../../modules/programs/bash
    ../../modules/programs/firefox
  ];
  home = {
    username = "chris";
    homeDirectory = "/home/chris";
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
      httpie
      jetbrains.idea-ultimate
      jq
      kubectl
      minikube
      mpv
      ncdu_2
      neofetch
      nixpkgs-review
      procs
      ripgrep
      rustc
      steam
      tdesktop
      tixati
      unzip
      vlc
      xsel
      yt-dlp
    ];
    file = {
      ".ideavimrc".text = ''
        let mapleader = " "
        set clipboard+=unnamed        -- use system clipboard
        set scrolloff = 15            -- keep 15 row buffer on screen edges
        set relativenumber = true     -- show relative distance between rows
        set hlsearch = false          -- remove highlighting after search
        set number = true             -- show current line number
        set NERDTree                  -- enable vim controls in file tree
        set highlightedyank           -- briefly hightlight copied text
      '';
      # DWM Stuff
      ".clock" = {
        text = ''
          #!/usr/bin/env bash
          while true; do
              xsetroot -name "$(date '+ %I:%M:%S %P ')"
              sleep 1
          done
        '';
        executable = true;
        };
      ".xinitrc" = {
        text = ''
          #!/usr/bin/env bash
          session=''${1}

          case $session in
            dwm)  "$HOME/.fehbg" &
                  xcompmgr &
                  xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
                  xset -dpms &
                  "$HOME/.clock" &
                  export _JAVA_AWT_WM_NONREPARENTING=1
                  exec dwm ;;
            kde)  export DESKTOP_SESSION=plasma
                  xinput set-prop 'Logitech G500' 'libinput Accel Speed' -0.65 &
                  exec startplasma-x11 ;;
          esac
        '';
        executable = true;
      };
      ".fehbg" = {
        text = ''
          #!/usr/bin/env bash
          feh --no-fehbg --bg-scale '/home/chris/Pictures/background.png'
        '';
        executable = true;
      };
    };
  };

  fonts.fontconfig.enable = true;

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    bat = {
      enable = true;
    };
  };
  targets = {
    genericLinux = {
      enable = true;
    };
  };

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
