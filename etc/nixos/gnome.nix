{ config, pkgs, ... }:

{ 
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome = {
    core-utilities.enable = false;
    tracker-miners.enable = false;
    tracker.enable = false;
  };

  environment.systemPackages = with pkgs; [
    # Tweaks
    gnome.gnome-tweaks

    # Extensions
    gnomeExtensions.forge
    gnomeExtensions.appindicator
    gnomeExtensions.audio-output-switcher
    gnomeExtensions.burn-my-windows
    gnomeExtensions.just-perfection
    gnomeExtensions.space-bar
    gnomeExtensions.transparent-top-bar-adjustable-transparency
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  services.xserver = {
    displayManager = {
      gdm = {
        enable = true;
      };
      defaultSession = "gnome";
    };
  };
}
