{ pkgs, ... }:

let
  user="wabri";
  description="Wabri";
in
{
  imports =
    [
      ../packages/fonts.nix
      ../packages/development.nix
    ];
  users.users.${user} = {
    isNormalUser = true;
    description = "${description}";
    createHome = true;
    group = "users";
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
    packages = with pkgs; [
      # Shell
      zsh
      zsh-powerlevel10k

      # cli
      exa
      bat
      htop
      trash-cli
      fzf
      tldr
      duf
      ncdu

      # Web
      brave

      # Apps
      bitwarden
    ];
    shell = pkgs.zsh;
    initialPassword = "asdf";
  };

  # Shell
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    enableCompletion = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
  
  # Editor
  programs.vim = {
    defaultEditor = true;
  };
}
