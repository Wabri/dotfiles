{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Editors
    neovim

    # Environment
    tmux
    nix-direnv

    # Tools
    tree-sitter
    clang

    # Cli
    delta
    jq
    fzf
    ripgrep
    
    # Tui
    lazygit
  ];
}
