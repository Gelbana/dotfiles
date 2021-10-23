# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d1f7fbcd-5415-45d4-955a-2c634eeea9a5";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F651-109D";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/315fd22a-bc15-460c-baef-45ab7ff8c4c6"; }];

  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
