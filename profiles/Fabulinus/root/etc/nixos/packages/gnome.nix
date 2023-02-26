{ config, pkgs, ... }:

{
  services.gnome = {
    core-utilities.enable = false;
    tracker-miners.enable = false;
    tracker.enable = false;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.systemPackages = with pkgs; [
    nordic
    nordzy-cursor-theme
    nordzy-icon-theme
    
    gnome.gnome-tweaks
    gnome.nautilus

    gnomeExtensions.pop-shell
    gnomeExtensions.appindicator
    gnomeExtensions.burn-my-windows
    gnomeExtensions.just-perfection
    gnomeExtensions.space-bar
    gnomeExtensions.transparent-top-bar-adjustable-transparency
    pop-launcher 
    gnomeExtensions.pop-launcher-super-key
  ];

}
