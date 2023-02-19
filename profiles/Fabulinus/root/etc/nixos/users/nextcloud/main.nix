{ pkgs, ... }:

let
  user="homecloud";
  description="My own Nextcloud istance";
in
{
  imports = 
    [
      ./packages.nix
      ./nextcloud.nix
      ../../desktop/gnome.nix
    ];

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
      "storage"
    ];
    shell = pkgs.bash;
  };

  users.users.root = {
    shell = pkgs.bash;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  #security.acme = {
  #  acceptTerms = true;
  #  # Replace the email here!
  #  email = "gabriele.puliti@proton.me";
  #};
}

