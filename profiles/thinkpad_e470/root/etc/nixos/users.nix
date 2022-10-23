{ pkgs, ... }:

{
  # Users --> Don't forget to set a password with ‘passwd’.
  users.users.wabri = {
    description = "Wabri";
    createHome = true;
    group = "users";
    isNormalUser = true;
    initialPassword = "asdf";
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "video" 
      "audio" 
      "docker"
      "libvirtd"
      "storage"
      "input"
    ];
    shell = pkgs.zsh;
  };

  users.users.root = {
    shell = pkgs.zsh;
  };
}
