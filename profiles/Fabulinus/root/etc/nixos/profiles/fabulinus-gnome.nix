{ config, pkgs, ... }:

{
  imports =
    [
      ./fabulinus.nix
      ../packages/gnome.nix
    ];

  networking.hostName = "Fabulinus";
}
