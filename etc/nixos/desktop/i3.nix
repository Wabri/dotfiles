{  pkgs, ... }:

{ 
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        polybar
        lxappearance
        arandr
        rofi
        flameshot
        betterlockscreen
        picom
        nitrogen
        dunst
        libnotify
        blueberry
        alsa-utils
        playerctl
        xorg.xev
        light
        font-manager
        networkmanagerapplet
        xfce.thunar
        pavucontrol
        batsignal
        acpi
        libsForQt5.kdeconnect-kde
      ];
    };
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      gdm = {
        enable = true;
      };
      defaultSession = "none+i3";
    };
  };
}
