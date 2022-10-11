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
  ];
  home = {
    username = "chris";
    homeDirectory = "/home/chris";
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

  home = {
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
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    # Shell
    bash = {
      enable = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        # Because there is a node_modules folder in ~ starship displays the node version when ~
        # Disabling because it's annoying and idk about js anyway.
        nodejs = {
          disabled = true;
        };
      };
    };
    # Terminal
    kitty = {
      # Must use: https://github.com/guibou/nixGL on fedora install because (I assume) of old video card.
      enable = true;
      theme = "Gruvbox Dark Hard";
      font = {
        name = "JetBrains Mono NL ExtraBold Nerd Font Complete";
        size = 9;
      };
      settings = {
        enable_audio_bell = false;
        visual_bell_duration = 0;
        window_alert_on_bell = false;
        background_opacity = "0.85";
        confirm_os_window_close = 0;
      };
    };
    tmux = {
      enable = true;
      extraConfig = "

        # indexing
        set -g renumber-windows on

        # mouse controls
        set -g mouse on

        # vim-style navigation
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        ## https://github.com/egel/tmux-gruvbox
        ## COLORSCHEME: gruvbox dark (medium)
        set-option -g status 'on'

        # default statusbar color
        set-option -g status-style bg=colour237,fg=colour223 # bg=bg1, fg=fg1

        # default window title colors
        set-window-option -g window-status-style bg=colour214,fg=colour237 # bg=yellow, fg=bg1

        # default window with an activity alert
        set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

        # active window title colors
        set-window-option -g window-status-current-style bg=red,fg=colour237 # fg=bg1

        # pane border
        set-option -g pane-active-border-style fg=colour250 #fg2
        set-option -g pane-border-style fg=colour237 #bg1

        # message infos
        set-option -g message-style bg=colour239,fg=colour223 # bg=bg2, fg=fg1

        # writing commands inactive
        set-option -g message-command-style bg=colour239,fg=colour223 # bg=fg3, fg=bg1

        # pane number display
        set-option -g display-panes-active-colour colour250 #fg2
        set-option -g display-panes-colour colour237 #bg1

        # clock
        set-window-option -g clock-mode-colour colour109 #blue

        # bell
        set-window-option -g window-status-bell-style bg=colour167,fg=colour235 # bg=red, fg=bg

        ## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
        set-option -g status-justify 'left'
        set-option -g status-left-style none
        set-option -g status-left-length '80'
        set-option -g status-right-style none
        set-option -g status-right-length '80'
        set-window-option -g window-status-separator ''

        set-option -g status-left '#[bg=colour241,fg=colour248] #S #[bg=colour237,fg=colour241,nobold,noitalics,nounderscore]'
        set-option -g status-right '#[bg=colour237,fg=colour239 nobold, nounderscore, noitalics]#[bg=colour239,fg=colour246] %Y-%m-%d  %H:%M #[bg=colour239,fg=colour248,nobold,noitalics,nounderscore]#[bg=colour248,fg=colour237] #h '

        set-window-option -g window-status-current-format '#[bg=colour214,fg=colour237,nobold,noitalics,nounderscore]#[bg=colour214,fg=colour239] #I #[bg=colour214,fg=colour239,bold] #W#{?window_zoomed_flag,*Z,} #[bg=colour237,fg=colour214,nobold,noitalics,nounderscore]'
        set-window-option -g window-status-format '#[bg=colour239,fg=colour237,noitalics]#[bg=colour239,fg=colour223] #I #[bg=colour239,fg=colour223] #W #[bg=colour237,fg=colour239,noitalics]'

        ## Neovim stuff
        set-option -sg escape-time 10
        set-option -g focus-events on
        set-option -g default-terminal 'screen-256color'
        set-option -sa terminal-overrides ',xterm-256color:RGB'
      ";
    };
    zellij = {
      enable = true;
      settings = {
      };
    };
    bottom = {
      enable = true;
      settings = {
        flags = {
          color = "gruvbox";
          group_processes = true;
        };
      };
    };
    # Desktop Applications
    firefox = {
      enable = true;
    };
    # GNU replacement tools
    lsd = {
      enable = true;
      enableAliases = true;
    };
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
