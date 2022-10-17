{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        plasma5 = {
          enable = true;
        };
      };
      displayManager = {
        sddm = {
          enable = true;
          theme = "Nordic";
        };
        defaultSession = "plasmawayland";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    # Tiling Window Management
    # libsForQt5.bismuth

    # Phone connection
    libsForQt5.kdeconnect-kde
  ];
  programs.dconf.enable = true;
}
