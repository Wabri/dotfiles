{ config, pkgs, ... }:

{
  imports =
    [
      ../configurations/i18n.nix
      ../configurations/networking.nix
      ../configurations/time.nix
      ../configurations/virtualisation.nix
      ../packages/common.nix
      ../services/layout.nix
      ../services/libinput.nix
      ../services/sound.nix
      ../services/printing.nix
      ../services/ssh.nix
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/e470"
    ];
}
