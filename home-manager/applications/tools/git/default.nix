{
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user = {
          name = "siph";
          email = "dawkins.chris.dev@gmail.com";
        };
      };
    };
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        side-by-side = true;
      };
    };
  };
}
