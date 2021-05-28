self: super: {
  gnomeExtensions = super.gnomeExtensions // {
    paperwm = super.gnomeExtensions.paperwm.overrideDerivation (old: {
      src = super.fetchFromGitHub {
        owner = "paperwm";
        repo = "PaperWM";
        rev = "e9f714846b9eac8bdd5b33c3d33f1a9d2fbdecd4";
        sha256 = "gZbS2Xy+CuQfzzZ5IwMahr3VLtyTiLxJTJVawml9sXE=";
      };
    });
  };
}
