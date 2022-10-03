{ pkgs, ... }:

{ 
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-12.2.3"
      "electron-13.6.9"
      "electron-14.2.9"
      "python3.9-poetry-1.1.12"
    ];
  };
  environment.systemPackages = with pkgs; [
    # Shell
    bash
    zsh

    # Shell Themes
    zsh-powerlevel10k

    # Terminal
    alacritty

    # Editors
    vim
    neovim

    # Web
    brave

    # Tools, cli, tui
    killall
    git
    tmux
    neofetch
    htop
    gtop
    ncdu
    duf
    tldr
    ripgrep
    exa
    bat
    wget
    vagrant
    fzf
    lsof
    asdf-vm

    # Appimage
    appimage-run

    # Themes
    nordic

    # App
    spotify
    obinskit
    vlc
    virt-manager
    bitwarden
    obs-studio
    obs-studio-plugins.wlrobs
    rpi-imager
    ventoy-bin
    mupdf
    qbittorrent
    onlyoffice-bin
    etcher

    # Chat
    tdesktop
    discord
    slack
  ];

  # Enable zsh
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
    enableCompletion = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
}
