{ config, pkgs, ... }:

{ 
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome = {
    core-utilities.enable = false;
    tracker-miners.enable = false;
    tracker.enable = false;
  };

  environment.systemPackages = with pkgs; [
    # Not Gnome
    wofi
    nordzy-cursor-theme
    nordzy-icon-theme

    # Tweaks
    gnome.gnome-tweaks

    # Extensions
    gnomeExtensions.pop-shell
    gnomeExtensions.appindicator
    gnomeExtensions.audio-output-switcher
    gnomeExtensions.burn-my-windows
    gnomeExtensions.just-perfection
    gnomeExtensions.space-bar
    gnomeExtensions.transparent-top-bar-adjustable-transparency
    gnomeExtensions.gsconnect
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
