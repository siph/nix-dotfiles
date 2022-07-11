{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "chris";
  home.homeDirectory = "/home/chris";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
   packages = with pkgs; [
     neofetch
   ];
  };

  programs = {
    # Shell
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      envExtra = "
        export EDITOR='lvim'
        export BROWSER='firefox'
        export MANPAGER='lvim +Man!'
        export TERM='xterm-256color'
      ";
      initExtra = "
        export PATH=~/.local/bin:$PATH
        alias vim='lvim'

        # Misc
        zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
        bindkey -v
        # Colors
        autoload -Uz colors && colors
      ";
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {

      };
    };
    # Terminal
    kitty = {
      enable = true;
      # theme = "GruvboxMaterialDarkHard";
      font = {
        name = "JetBrainsMonoExtraBold Nerd Font";
        size = 9;
      };
      settings = {
        enable_audio_bell = false;
        visual_bell_duration = 0;
        window_alert_on_bell = false;
        background_opacity = "0.85";
      };
    };
    tmux = {
      enable = true;
      extraConfig = "

      ";
    };
    git = {
      enable = true;
      userName = "siph";
      userEmail = "dawkins.chris.dev@gmail.com";
    };
    neovim = {
      enable = true;
      # vimAlias = true;
    };
    lsd = {
      enable = true;
      enableAliases = true;
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
