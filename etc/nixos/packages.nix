{ pkgs, ... }:

{ 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-13.6.9"
      "electron-14.2.9"
      "python3.9-poetry-1.1.12"
    ];
  };
  environment.systemPackages = with pkgs; [
    # Shell
    bash
    zsh

    # Terminal
    alacritty
    
    # Tools, cli, tui
    killall
    git
    tmux
    neofetch
    htop
    ncdu
    duf
    tldr
    poetry
    ripgrep
    exa
    bat
    wget
    vagrant
    starship
    fzf
    lsof
    qbittorrent
    koreader

    # Editors
    vim
    neovim

    # Web
    firefox

    # Appimage
    appimage-run

    # Themes
    nordic

    # App
    gnome.nautilus
    spotify
    obinskit
    vlc
    virt-manager
    bitwarden
    obs-studio
    rpi-imager
    ventoy-bin
    mupdf
  ];

  # Steam
  programs.steam = {
    enable = true;
  };

  # Enable zsh
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
  };
  programs.zsh.enableCompletion = true;
}
