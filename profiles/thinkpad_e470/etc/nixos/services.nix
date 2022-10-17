{ pkgs, ... }:

{
  services = {

    # Enable xserver
    xserver = {
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
    };

    # External device automounting
    devmon.enable = true; # Enable external device automounting.
    udisks2.enable = true; # Enable udisks2.

    # Enable ssh
    openssh.enable = true;

    # Enable printing 
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    # Enable sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    # Enable bluethoot
    blueman.enable = true;
  };
}
