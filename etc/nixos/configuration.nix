{ pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/lenovo/thinkpad/x220>
      ./hardware-configuration.nix
      ./efi-bootloader.nix
      ./networking.nix
      ./users.nix
      ./time.nix
      ./i3.nix
      ./packages.nix
      ./virtualization.nix
      ./printer.nix
      ./sound.nix
      ./bluetooth.nix
      ./services.nix
      ./theme.nix
    ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "22.05"; 
}

