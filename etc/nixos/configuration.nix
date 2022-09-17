{ pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/lenovo/thinkpad/e470>
      ./hardware-configuration.nix
      ./efi-bootloader.nix
      ./networking.nix
      ./users.nix
      ./time.nix
      ./virtualization.nix
      ./printer.nix
      ./sound.nix
      ./bluetooth.nix
      ./services.nix
      ./theme.nix
      ./packages.nix
      ./gnome.nix
    ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "unstable"; 
}

