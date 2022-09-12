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
      ./virtualization.nix
      ./printer.nix
      ./sound.nix
      ./bluetooth.nix
      ./services.nix
      ./theme.nix
      ./packages.nix
      ./sway.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "unstable"; 
}

