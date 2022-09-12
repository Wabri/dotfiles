{ config, pkgs, ... }:

{ 
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome = {
    core-utilities.enable = false;
    tracker-miners.enable = false;
    tracker.enable = false;
  };
}
