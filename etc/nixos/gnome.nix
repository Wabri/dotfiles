{ config, pkgs, ... }:

{ 
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome = {
    core-utilities.enable = false;
    tracker-miners.enable = false;
    tracker.enable = false;
  };
  services.xserver.desktopManager.gnome.flashback.customSessions = [
    {
      wmName = "i3";
      wmLabel = "i3";
      wmCommand = "${pkgs.i3-gaps}";
      enableGnomePanel = true;
    }
  ];
}
