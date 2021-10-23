self: super: {
  gnomeExtensions = super.gnomeExtensions // {
    dash-to-dock = super.gnomeExtensions.dash-to-dock.overrideDerivation (old: {
      buildInputs = old.buildInputs ++ [ super.sassc ];
      src = super.fetchFromGitHub {
        owner = "micheleg";
        repo = "dash-to-dock";
        rev = "master";
        sha256 = "sha256-cKH4d4e+e4BY4di5PDOZ1g+Ro4qJrbRvRMrXgGSlOdM=";
      };
    });
  };
}
