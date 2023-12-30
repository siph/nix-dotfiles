{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    terminal = "screen-256color";
    mouse = true;
    escapeTime = 10;
    plugins = with pkgs; [
      tmuxPlugins.gruvbox
    ];
    tmuxp.enable = true;
    extraConfig = "
      # indexing
      set -g renumber-windows on

      # vim error
      set-option -sa terminal-features 'xterm-kitty:RGB'
    ";
  };
}
