# Edi this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  #  boot.loader.grub.enable = true;
  #  boot.loader.grub.version = 2;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  networking.hostName = "devbox-nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";
  time.hardwareClockInLocalTime = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp7s0.useDHCP = true;
  networking.interfaces.br0.useDHCP = true;
  networking.bridges = { "br0" = { interfaces = [ "enp7s0" ]; }; };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  fonts.fonts = with pkgs; [ source-han-sans ];
  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sound.
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nano.isNormalUser = true;
  users.users.nano.shell = pkgs.zsh;
  users.users.nano.extraGroups =
    [ "wheel" "plugdev" "networkmanager" "libvirtd" ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_19;
  # Environment system packages
  # $ nix search wget (to search)
  environment.systemPackages = with pkgs; [
    wget
    firefox
    alacritty
    vim
    fzf
    git
    neofetch
    cachix
    unzip
    virtmanager
    win-virtio
    killall
    chromium
    gnome.gnome-tweaks
    gnomeExtensions.gsconnect
    gnomeExtensions.volume-mixer
    gnomeExtensions.pano
    gsound
    libgda
    libva-utils
    bottles
    gnome-blackbox
    gcc
    cmake
    xclip
    gnumake
    wl-clipboard
  ];
  programs.java.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia.package =
    config.boot.kernelPackages.nvidiaPackages.legacy_470;
  programs.dconf.enable = true;

  # Exclude unused GNOME packages
  environment.gnome.excludePackages = with pkgs; [
    gnome.cheese
    gnome-photos
    gnome.gnome-music
    gnome.gnome-terminal
    gnome.gedit
    gnome-tour
  ];

  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings.trusted-users = [ "root" "nano" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.ovmf.enable = true;

  # No touching
  system.stateVersion = "20.09";
}
