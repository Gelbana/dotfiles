self: super: {
  gnomeExtensions = super.gnomeExtensions // {
    paperwm = super.gnomeExtensions.paperwm.overrideDerivation
      (old: {
        src = super.fetchFromGitHub
          {
            owner = "PaperWM";
            repo = "PaperWM";
            rev = "develop";
            sha256 = "sha256-1fmI9bgN6X8Uo4gmuNJfz8JGamcLhdLBhn57izVqCk4=";
          };
      });
  };
}
