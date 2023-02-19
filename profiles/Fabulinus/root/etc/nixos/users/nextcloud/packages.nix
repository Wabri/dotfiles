{ pkgs, ... }:

{ 
  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    # Shell
    bash

    # Terminal
    alacritty

    # Web
    firefox

    # Editors
    vim

    # Tools, cli, tui
    killall
    git
    tmux
    neofetch
    htop
    ncdu
    duf
    wget
    ffmpeg
    certbot
  ];

  # Vim
  programs.vim = {
    defaultEditor = true;
  };
}
