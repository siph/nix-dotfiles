{ lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    keyMode = "vi";
    terminal = "screen-256color";
    plugins = with pkgs; [
      tmuxPlugins.gruvbox
    ];
    extraConfig = "
      # indexing
      set -g renumber-windows on

      # mouse controls
      set -g mouse on
    ";
  };
}
