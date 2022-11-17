self: super: {
  gnomeExtensions = super.gnomeExtensions // {
    pano = super.callPackage "${
        builtins.fetchTarball
        "https://github.com/michojel/nixpkgs/archive/gnome-shell-extension-pano.tar.gz"
      }/pkgs/desktops/gnome/extensions/pano" { };
  };
}
