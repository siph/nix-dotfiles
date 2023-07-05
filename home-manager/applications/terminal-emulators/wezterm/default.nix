{
  programs.wezterm = {
    enable = true;
    extraConfig = (builtins.readFile ./wezterm.lua);
  };

  xdg.configFile."wezterm/colors/GrooveBawgs.toml".source = ./GrooveBawgs.toml;
}
