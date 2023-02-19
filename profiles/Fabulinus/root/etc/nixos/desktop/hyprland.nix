{ config, pkgs, ...}: let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  hyprland = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
  }).defaultNix;
in {
  imports = [
    hyprland.nixosModules.default
  ];

  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.default;
  };

  environment.systemPackages = with pkgs; [
    wofi
  ];

}
