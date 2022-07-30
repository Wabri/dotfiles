# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ 
    "xhci_pci" 
    "ahci" 
    "usb_storage" 
    "sd_mod" 
    "sdhci_pci" 
  ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/44fbc3f4-671e-4af2-8c50-0e039b8be775";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/268E-D723";
      fsType = "vfat";
    };

  swapDevices = [ 
    { device = "/dev/disk/by-uuid/90740ce2-c04e-430c-ac15-652367e011a9"; }
  ];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

}
