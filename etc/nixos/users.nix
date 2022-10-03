{ pkgs, ... }:

{
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

  users.users.root = {
    shell = pkgs.zsh;
  };
}
