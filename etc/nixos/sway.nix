{ config, pkgs, ... }:

{ 
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      xwayland
      swaylock
      swayidle
      mako
      wofi
      waybar
      brightnessctl
      playerctl
      libinput
      wl-clipboard
      xorg.xev
      autotiling
      flashfocus
      grim
      slurp
      xdg-desktop-portal-wlr
    ];
  };
  programs.waybar = {
    enable = true;
  };
}
