self: super: {
  gnomeExtensions = super.gnomeExtensions // {
    dash-to-dock = super.gnomeExtensions.dash-to-dock.overrideDerivation (old: {
      buildInputs = old.buildInputs ++ [ super.sassc ];
      src = super.fetchFromGitHub {
        owner = "ewlsh";
        repo = "dash-to-dock";
        rev = "e4beec847181e4163b0a99ceaef4c4582cc8ae4c";
        sha256 = "7UVnLXH7COnIbqxbt3CCscuu1YyPH6ax5DlKdaHCT/0=";
      };
    });
  };
}
