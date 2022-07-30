{  pkgs, ... }:

{ 
  services.xserver = {
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
      ];
    };
  };
}
