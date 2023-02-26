{ config, pkgs, ... }:

{
  imports =
    [
      ./fabulinus.nix
      ../packages/sway.nix
    ];

  networking.hostName = "Fabulinus";
}
