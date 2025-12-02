#!/usr/bin/env bash

# --- ~/.config
DIR=$(pwd)
TARGET=$HOME

dotfiles=(alacritty asdf bash browsir dunst fuzzel ghostty git gnome hyprland i3wm kitty logseq mako nvim picom rofi scripts spicetify sway swaync systemd-user templates tmux waybar wofi zsh)

for dotfile in "${dotfiles[@]}"; do
    stow -d "$DIR" -t "$TARGET" "$dotfile"
done
