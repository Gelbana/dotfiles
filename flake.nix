{
  description = "A nixos config.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { self, nixpkgs, nixpkgs-master, home-manager, neovim-nightly-overlay }: {
      nixosConfigurations = {
        big-nix = nixpkgs.lib.nixosSystem {
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
                (import ./config/gnome/paperwm/paperwm.nix)
                (import ./config/gnome/dash-to-dock/dash-to-dock.nix)
              ];
            })
          ];
        };
      };
    };
}
