{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    iosevka
    powerline-fonts
    nerdfonts
    source-code-pro
  ];
  programs.dconf.enable = true;
}
