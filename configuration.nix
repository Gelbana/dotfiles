# Edi this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./games/genshin.nix
  ];

  # Use the GRUB 2 boot loader.
  #  boot.loader.grub.enable = true;
  #  boot.loader.grub.version = 2;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  networking.hostName = "big-nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";
  time.hardwareClockInLocalTime = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  programs.noisetorch.enable = true;

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
    driSupport32Bit = true;
  };

  hardware.openrazer.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nano.isNormalUser = true;

  users.users.nano.extraGroups =
    [ "wheel" "plugdev" ]; # Enable ‘sudo’ for the user.

  boot.blacklistedKernelModules = [ "nouveau" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    firefox
    alacritty
    vim
    fzf
    git
    cachix
    neofetch
    unzip
    virtmanager
    win-virtio
    killall
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    # displayManager.autoLogin.enable = true;
    # displayManager.autoLogin.user = "nano";
    desktopManager.plasma5.enable = true;
    videoDrivers = [ "nvidia" ];
    exportConfiguration = true;
    monitorSection = ''
      VendorName     "Unknown"
      ModelName      "Samsung C49RG9x"
      HorizSync       190.0 - 190.0
      VertRefresh     48.0 - 120.0
      Option         "DPMS"
    '';
    deviceSection = ''
      VendorName     "NVIDIA Corporation"
      BoardName      "GeForce GTX 1070"
    '';
    screenSection = ''
      DefaultDepth    24
      Option         "Stereo" "0"
      Option         "nvidiaXineramaInfoOrder" "DFP-6"
      Option         "metamodes" "5120x1440 +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On, AllowGSYNCCompatible=On}"
      Option         "MultiGPU" "Off"
      Option         "BaseMosaic" "off"
      SubSection     "Display"
        Depth       24
      EndSubSection
                '';
    inputClassSections = [''
      Identifier "mouse accel"
      Driver "libinput"
      MatchIsPointer "on"
      Option "AccelProfile" "flat"
      Option "AccelSpeed" "0"
    ''];

    # displayManager = {
    #   defaultSession = "none+awesome";
    #   lightdm.enable = true;
    #   lightdm.greeters.gtk.enable = true;

    # };
    # windowManager.awesome.enable = true;
    # windowManager.awesome.luaModules = with pkgs.luaPackages; [
    #   luarocks
    #   luadbi-mysql
    # ];
  };

  programs.steam.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix = {
    trustedUsers = [ "root" "nano" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

}
