{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    tmuxp.enable = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    terminal = "screen-256color";
    mouse = true;
    escapeTime = 10;

    plugins = with pkgs; [
      tmuxPlugins.gruvbox
    ];

    extraConfig = ''
      # indexing
      set -g renumber-windows on
      set-option -sa terminal-overrides ",alacritty*:Tc"
    '';
  };
}
