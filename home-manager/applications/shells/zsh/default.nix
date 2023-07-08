{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    plugins = [
      # This will make `nix-shell` use zsh instead of bash.
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
    envExtra = "
      export EDITOR='nvim'
      export BROWSER='firefox'
      export MANPAGER='nvim +Man!'
      export TERM='xterm-256color'
    ";
    initExtra = "
      alias cat='bat'
      alias startx-dwm='startx ~/.xinitrc dwm'
      alias startx-kde='startx ~/.xinitrc kde'
      alias startx-xmonad='startx ~/.xinitrc xmonad'
      alias tree='broot'

      # Misc
      zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
      bindkey -v
      # Colors
      autoload -Uz colors && colors
    ";
  };
}
