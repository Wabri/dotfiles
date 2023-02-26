{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ./profiles/fabulinus-i3.nix
      ./users/root.nix
      ./users/wabri.nix
    ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 8d";
  };

  system.stateVersion = "unstable";
}
