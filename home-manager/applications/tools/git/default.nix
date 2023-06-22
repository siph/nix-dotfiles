{ ... }:
{
  programs.git = {
      enable = true;
      userName = "siph";
      userEmail = "dawkins.chris.dev@gmail.com";
      delta = {
        enable = true;
        options = {
          side-by-side = true;
        };
      };
      lfs.enable = true;
  };
}
