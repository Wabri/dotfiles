{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Web
    firefox

    # Terminal
    alacritty

    # Editor
    vim

    # utils
    git
    killall
    neofetch
  ];
}
