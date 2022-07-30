{ pkgs, ... }:

{
  # EFI boot loader
  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      device = "nodev";
    };
    efi = {
      canTouchEfiVariables = true; 
      efiSysMountPoint = "/boot";
    };
  };
}
