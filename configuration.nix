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

  fonts.fonts = with pkgs; [ source-han-sans ];
  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  programs.noisetorch.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools-lunarg
      vaapiVdpau
    ];
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nano.isNormalUser = true;
  users.users.nano.shell = pkgs.zsh;
  users.users.nano.extraGroups =
    [ "wheel" "plugdev" "networkmanager" "corectrl" ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Environment system packages
  # $ nix search wget (to search)
  environment.systemPackages = with pkgs; [
    pulseaudio
    wget
    glibc
    firefox-wayland
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
    libratbag
    libpcap
    tcpdump
    piper
    gnomeExtensions.gsconnect
    gnomeExtensions.volume-mixer
    libva-utils
    glxinfo

    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools-lunarg
    wineWowPackages.unstable
    (winetricks.override { wine = wineWowPackages.unstable; })
  ];

  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };
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

  services.ratbagd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''
      Option "VariableRefresh" "true"
    '';
    wacom.enable = true;
  };

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${
      pkgs.writeText "gdm-monitors.xml" ''
        <monitors version="2">
          <configuration>
            <logicalmonitor>
              <x>0</x>
              <y>0</y>
              <scale>1</scale>
              <primary>yes</primary>
              <monitor>
                <monitorspec>
                  <connector>DP-1</connector>
                  <vendor>SAM</vendor>
                  <product>C49RG9x</product>
                  <serial>H1AK500000</serial>
                </monitorspec>
                <mode>
                  <width>5120</width>
                  <height>1440</height>
                  <rate>119.97019195556641</rate>
                </mode>
              </monitor>
            </logicalmonitor>
          </configuration>
          <configuration>
            <logicalmonitor>
              <x>0</x>
              <y>0</y>
              <scale>1</scale>
              <primary>yes</primary>
              <monitor>
                <monitorspec>
                  <connector>DP-4</connector>
                  <vendor>SAM</vendor>
                  <product>C49RG9x</product>
                  <serial>H1AK500000</serial>
                </monitorspec>
                <mode>
                  <width>5120</width>
                  <height>1440</height>
                  <rate>119.97019195556641</rate>
                </mode>
              </monitor>
            </logicalmonitor>
          </configuration>
        </monitors>
              ''
    }"
  ];
  environment.sessionVariables = { MOZ_ENABLE_WAYLAND = "1"; };
  # Exclude unused GNOME packages
  environment.gnome.excludePackages = with pkgs; [
    gnome.cheese
    gnome-photos
    gnome.gnome-music
    gnome.gnome-terminal
    gnome.gedit
    gnome-tour
  ];

  security.wrappers = {
    wine = {
      source = "${pkgs.wineWowPackages.unstable}/bin/wine";
      capabilities = "cap_net_raw,cap_net_admin,cap_sys_ptrace=eip";
      owner = "nano";
      group = "users";
      permissions = "u+rx,g+rx";
    };
    wine64 = {
      source = "${pkgs.wineWowPackages.unstable}/bin/wine64";
      capabilities = "cap_net_raw,cap_net_admin,cap_sys_ptrace=eip";
      owner = "nano";
      group = "users";
      permissions = "u+rx,g+rx";
    };
    wineserver = {
      source = "${pkgs.wineWowPackages.unstable}/bin/wineserver";
      capabilities = "cap_net_raw,cap_net_admin,cap_sys_ptrace=eip";
      owner = "nano";
      group = "users";
      permissions = "u+rx,g+rx";
    };
  };
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    trustedUsers = [ "root" "nano" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # No touching
  system.stateVersion = "20.09";
}
