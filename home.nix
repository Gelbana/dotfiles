{ pkgs, inputs, ... }:

{
  # temporarily disable gnome settings until it works nicely
  # imports = [ ./config/dconf.nix ];
  home.stateVersion = "20.09";

  home.packages = with pkgs; [
    # General stuff
    btop
    jetbrains-mono
    inter
    overpass
    inconsolata-nerdfont
    mononoki
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.tiling-assistant
    gnomeExtensions.dash-to-dock
    gnomeExtensions.paperwm
    gnomeExtensions.impatience
    gnomeExtensions.reorder-workspaces
    gnomeExtensions.pano
    papirus-icon-theme
    celluloid
    chromium
    appimage-run
    remmina
    rocketchat-desktop



    # Emacs related stuff
    binutils
    gnutls # for TLS connectivity
    fd # faster projectile indexing
    imagemagick # for image-dired
    zstd # for undo-fu-session/undo-tree compression
    ripgrep
    emacs-all-the-icons-fonts
    pandoc
    plantuml
    (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))
    mu # email
    isync # email
    msmtp

    # Nix related stuff
    rnix-lsp
    nixfmt

    # Dev related stuff
    mono
    dotnet-sdk
    omnisharp-roslyn
    jetbrains.rider
    insomnia
    azuredatastudio

    # Android dev related stuff
    android-tools
    android-studio
    inkscape

  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs28NativeComp;
    extraPackages = epkgs: [ epkgs.vterm epkgs.sqlite3 ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
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
    userName = "aden.messori";
    userEmail = "aden.messori@infinitypath.com.au";
  };

  programs.alacritty = {
    enable = true;
    settings = import ./config/alacritty/alacritty.nix;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };



  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

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
    initExtra = ''
      bindkey '^[OA' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
    '';
  };
}
