{ pkgs, ... }:

{
  imports =
    [
       "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/e470"
      ./hardware-configuration.nix
      ./efi-bootloader.nix
      ./networking.nix
      ./users.nix
      ./time.nix
      ./virtualization.nix
      ./services.nix
      ./security.nix
      ./fonts.nix
      ./packages.nix
      ./desktop/plasma.nix
    ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
  system.stateVersion = "unstable"; 
}

