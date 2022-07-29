{ config, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/lenovo/thinkpad/x220>
      ./hardware-configuration.nix
      ./i3.nix
      ./sway.nix
      ./packages.nix
    ];

  # EFI boot loader
  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      device = "nodev";
    };
    efi = {
      canTouchEfiVariables = true; 
      efiSysMountPoint = "/boot";
    };
  };

  # Networking
  networking = {
    hostName = "fabulinus"; # Define your hostname.
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp4s0.useDHCP = true;
      wlp5s0.useDHCP = true;
    };
  };

  # Hardware enable
  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  # Printer
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  # Enable sound.
  sound.enable = true;
  services.mpd.enable = true;

  # Enable Bluetooth
  services.blueman.enable = true;

  # Enable Virtualization
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

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
      "audio" 
      "docker"
      "libvirtd"
      "storage"
    ];
    shell = pkgs.zsh;
  };

  # Xserver
  services.xserver = {
    enable = true;
    layout = "us";
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        disableWhileTyping = false;
        clickMethod = "clickfinger";
      };
    };
    displayManager = {
      gdm = {
        enable = true;
      };
      defaultSession = "none+i3";
    };
  };

  # Fonts
  fonts.fonts = with pkgs; [
    iosevka
    powerline-fonts
    nerdfonts
    source-code-pro
  ];

  # Enable power management
  powerManagement.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}

