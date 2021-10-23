self: super: {
  gnomeExtensions = super.gnomeExtensions // {
    paperwm = super.gnomeExtensions.paperwm.overrideDerivation
      (old: { src = /home/nano/code/PaperWM; });
  };
}
