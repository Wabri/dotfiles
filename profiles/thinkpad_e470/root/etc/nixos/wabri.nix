{ pkgs, ... }:

let
  user="wabri";
  description="Wabri";
in
{
  # Users --> Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    description = "${description}";
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

