{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    terminal = "screen-256color";
    escapeTime = 10;
    plugins = with pkgs; [
      tmuxPlugins.gruvbox
    ];
    tmuxp.enable = true;
    extraConfig = "
      # indexing
      set -g renumber-windows on

      # mouse controls
      set -g mouse on
    ";
  };
}
