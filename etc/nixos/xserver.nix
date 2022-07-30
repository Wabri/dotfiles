
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

