{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true; # Enable the X11 windowing system.
      desktopManager.plasma5 = {
        enable = true;
      };
      displayManager = {
        sddm = {
          enable = true;
        };
        defaultSession = "plasma";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # Tiling Window Management
    libsForQt5.bismuth
    libsForQt5.kdeconnect-kde
  ];
  programs.dconf.enable = true;
}
