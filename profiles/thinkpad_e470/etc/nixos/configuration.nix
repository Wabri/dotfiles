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
      ./desktop/i3.nix
    ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 8d";
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "weekly";
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  system.stateVersion = "unstable"; 
}

