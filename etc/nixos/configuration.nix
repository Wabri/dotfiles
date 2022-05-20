{ config, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/lenovo/thinkpad/x220>
      ./hardware-configuration.nix
    ];

  # EFI boot loader
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = true;
    useOSProber = true;
    device = "nodev";
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking = {
    hostName = "fabulinus"; # Define your hostname.
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;
    interfaces.wlp5s0.useDHCP = true;
  };

  # Hardware enable
  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  services.mpd.enable = true;

  # Enable Bluetooth
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Users --> Don't forget to set a password with ‘passwd’.
  users.users.wabri = {
    description = "Wabri";
    createHome = true;
    group = "users";
    isNormalUser = true;
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "video" 
      "docker"
    ];
    shell = pkgs.zsh;
  };

  # Xserver = libinput + sddm
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        disableWhileTyping = false;
        clickMethod = "clickfinger";
      };
    };
    displayManager = {
      sddm = {
        enable = true;
      };
      defaultSession = "sway";
    };
  };

  # Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      xwayland
      swaylock
      swayidle
      wl-clipboard
      mako
      alacritty
      wofi
      waybar
      brightnessctl
      libinput
      nitrogen
      flameshot
    ];
  };
  programs.waybar = {
    enable = true;
  };

  # Fonts
  fonts.fonts = with pkgs; [
    iosevka
    powerline-fonts
    nerdfonts
    source-code-pro
  ];

  # Enable zsh
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
    };
  };
  programs.zsh.enableCompletion = true;

  # Enable power management
  powerManagement.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
         "electron-11.5.0"
    ];
  };
  environment.systemPackages = with pkgs; [
    # Shell
    bash
    zsh
    
    # Tools, cli, tui
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

    # Editors
    vim
    neovim

    # Web
    firefox

    # App
    spotify
    obinskit
    vlc
    virtualbox
    bitwarden
    obs-studio
    etcher
  ];

  # Docker
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "21.11"; # Did you read the comment?
}

