{ pkgs, ... }:

{ 
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        polybar
        lxappearance
        nordic
        nordzy-cursor-theme
        nordzy-icon-theme
        arandr
        rofi
        flameshot
        betterlockscreen
        picom
        nitrogen
        dunst
        libnotify
        alsa-utils
        playerctl
        xorg.xev
        light
        font-manager
        networkmanagerapplet
        blueberry
        xfce.thunar
        pavucontrol
        batsignal
        acpi
        libinput-gestures
        wmctrl
        sox
        xclip
	xss-lock
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

