{ pkgs, ... }: {
  services.xserver = {
    enable = true;   
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    displayManager = {
      sddm = {
        enable = true;
      };
      defaultSession = "xfce";
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };
}
