{ pkgs, ... }:

{ 
  networking = {
    hostName = "fabulinus"; # Define your hostname.
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp4s0.useDHCP = true;
      wlp5s0.useDHCP = true;
    };
    firewall.enable = false;
  };
}
