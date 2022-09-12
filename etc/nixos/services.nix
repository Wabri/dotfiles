{ ... }:

{
  services = {
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
    openssh.enable = true;
  };
}
