#!/usr/bin/env bash

# --- ~/.config
DIR=$(pwd)
TARGET=$HOME

dotfiles=(nvim tmux zsh)

for dotfile in "${dotfiles[@]}"; do
    stow -d "$DIR" -t "$TARGET" "$dotfile"
done
