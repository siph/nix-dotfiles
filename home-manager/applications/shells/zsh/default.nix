{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      MANPAGER = "nvim +Man!";
      TERM = "xterm-256color";
    };
    shellAliases = {
      cat = "bat";
      tree = "broot";
    };
    initExtra = "zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'";
  };
}
