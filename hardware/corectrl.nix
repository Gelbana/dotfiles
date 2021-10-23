final: prev: {
  corectrl = prev.corectrl.overrideDerivation (old: {
    name = "corectrl-1.2.1";
    version = "1.2.1";
    src = prev.fetchurl {
      url =
        "https://gitlab.com/corectrl/corectrl/-/archive/v1.2.1/corectrl-v1.2.1.tar.gz";
      sha256 = "sha256-+YTlsj81xu9ONqQxoJ1u20JwhPb85ftsY9boFSgsols=";
    };
  });
}
