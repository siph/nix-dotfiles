{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      userChrome = ''
        @import "${
          builtins.fetchGit {
            url = "https://github.com/rockofox/firefox-minima";
            ref = "main";
            rev = "932a99851b5f2db8b58aa456e5d897e278c69574";
          }
        }/userChrome.css";
      '';
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
