{ ... }:

{
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      disableWhileTyping = false;
      clickMethod = "clickfinger";
    };
  };
}
