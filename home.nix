{ pkgs, inputs, ... }:

{
  # temporarily disable gnome settings until it works nicely
  # imports = [ ./config/dconf.nix ];

  home.packages = with pkgs; [
    htop
    jetbrains-mono
    inconsolata-nerdfont
    gnomeExtensions.paperwm
    gnomeExtensions.dash-to-dock
    gnomeExtensions.audio-switcher-40
    gnomeExtensions.appindicator
    gnomeExtensions.fly-pie
    gnomeExtensions.blur-my-shell
    mpv
    discord
    chromium
    steam-run
    audacity
    lutris
    appimage-run

    papirus-icon-theme
    obs-studio

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
    enableZshIntegration = true;
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          sha256 = "sha256-Ptxik1r6anlP7QTqsN1S2Tli5lyRibkgGlVlwWZRG3k=";
        };
      }
    ];
  };

  home.file.".doom.d" = {
    source = ./config/doom-emacs;
    recursive = true;
  };
}
