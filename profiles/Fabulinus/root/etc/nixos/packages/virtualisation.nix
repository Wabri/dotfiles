{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Docker
    lazydocker

    # Docker
    vagrant
    virt-manager

    # Other
    distrobox
  ];
}
