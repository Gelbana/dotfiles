{ pkgs, inputs, ... }:

{
  # temporarily disable gnome settings until it works nicely
  # imports = [ ./config/dconf.nix ];

  home.packages = with pkgs; [
    htop
    jetbrains-mono
    inconsolata-nerdfont
    gnomeExtensions.paperwm
    gnomeExtensions.vertical-overview
    gnomeExtensions.cleaner-overview
    gnomeExtensions.dash-to-dock
    gnomeExtensions.audio-switcher-40
    gnomeExtensions.appindicator
    mpv
    discord-canary
    noisetorch

    # emacs dependencies
    binutils
    gnutls # for TLS connectivity

    # Optional dependencies
    fd # faster projectile indexing
    imagemagick # for image-dired
    zstd # for undo-fu-session/undo-tree compression
    ripgrep
    emacs-all-the-icons-fonts
    pandoc
    plantuml

    # helping find nix syntax error
    rnix-lsp
    nixfmt

  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      exec fish
    '';
  };

  programs.emacs = {
    enable = true;
    #    package = pkgs.emacsPgtkGcc;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Gelbana";
    userEmail = "rubapiggy@gmail.com";
  };

  programs.alacritty = {
    enable = true;
    settings = import ./config/alacritty/alacritty.nix;
  };

  gtk = {
    enable = true;
    theme.name = "Dracula";
    theme.package = pkgs.dracula-theme;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraConfig = builtins.readFile ./config/neovim/init.vim;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      dracula-vim
      nvim-lspconfig
      vim-which-key
      completion-nvim
      fzf-vim
    ];
  };

  programs.rofi = {
    enable = true;
    theme = ./config/rofi/dracula.rasi;
  };

  programs.fish = {
    enable = true;
    plugins = [{
      name = "dracula";
      src = pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "fish";
        rev = "28db361b55bb49dbfd7a679ebec9140be8c2d593";
        sha256 = "vdqYlEyYvlPVgTkwXbE8GVZo0UBBT88JyMSWYykhfx4=";
      };
    }];
  };
  programs.autorandr = { enable = true; };

  #   # windowManager.awesome = { enable = true; };
  # };

  home.file.".config/awesome/rc.lua".source = ./config/awesomewm/rc.lua;
  home.file.".doom.d" = {
    source = ./config/doom-emacs;
    recursive = true;
  };
}
