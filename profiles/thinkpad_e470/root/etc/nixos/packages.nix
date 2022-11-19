{ pkgs, ... }:

{ 
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-13.6.9"
      "electron-12.2.3"
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

    # Web
    brave

    # Editors
    neovim

    # Tools, cli, tui
    jq
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
    lazygit
    lazydocker
    ffmpeg
    onefetch
    direnv
    nix-direnv
    unzip
    fd
    tree-sitter
    pueue
    tlp
    trash-cli
    delta

    # Themes
    nordic
    nordzy-cursor-theme
    nordzy-icon-theme

    # App
    spotify
    obinskit
    vlc
    virt-manager
    bitwarden
    rpi-imager
    ventoy-bin
    mupdf
    qbittorrent
    onlyoffice-bin
    etcher
    
    # Chat
    # tdesktop
    # discord
    # slack
  ];

  # Overlays
  #nixpkgs.overlays = [
  #  ( self: super: {
  #    discord = super.discord.overrideAttrs (
  #      _: { 
  #        src = builtins.fetchTarball {
  #          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
  #        };
  #      }
  #    );
  #  })
  #];

  # nix options for derivations to persist garbage collection
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  # ZSH
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
    enableCompletion = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };

  # Vim
  programs.vim = {
    defaultEditor = true;
  };
}
