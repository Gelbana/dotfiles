{
  description = "A nixos config.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    home-manager.url = "github:nix-community/home-manager";
    blackbox.url = "github:mitchmindtree/blackbox.nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-master
    , home-manager
    , neovim-nightly-overlay
    , emacs-overlay
    , blackbox
    }: {
      nixosConfigurations = {
        devbox-nix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nano = import ./home.nix;
            }
            ({ pkgs, ... }: {
              nixpkgs.overlays = [
                neovim-nightly-overlay.overlay
                emacs-overlay.overlay
                (_: _: {
                  gnome-blackbox = blackbox.packages.x86_64-linux.blackbox;
                })
                (import /home/nano/dotfiles/config/gnome/pano)
                # (import /home/nano/dotfiles/packages/emacs)
              ];
            })
          ];
        };
      };
    };
}
