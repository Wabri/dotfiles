{ config, ... }:

{
  imports =
    [
      ./fabulinus.nix
      ../packages/i3.nix
    ];

  networking.hostName = "Fabulinus";
}
