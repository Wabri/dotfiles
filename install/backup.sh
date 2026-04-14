#!/usr/bin/env bash

# Backup existing dotfiles before installation

set -e

BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
DOTFILES_TO_BACKUP=(
    ".zshrc"
    ".tmux.conf"
    ".aliases"
    ".gitconfig"
    ".config/nvim"
    ".config/sway"
    ".config/niri"
    ".config/i3"
    ".config/kitty"
    ".config/alacritty"
    ".config/waybar"
    ".config/rofi"
    ".config/wofi"
    ".config/mako"
    ".config/dunst"
    ".config/hypr"
    ".config/gnome_scripts"
)

backup_dotfiles() {
    local backed_up=false

    echo "🔍 Checking for existing dotfiles..."

    for dotfile in "${DOTFILES_TO_BACKUP[@]}"; do
        local target="$HOME/$dotfile"

        if [[ -e "$target" ]] && [[ ! -L "$target" ]]; then
            if [[ "$backed_up" == false ]]; then
                echo "📦 Creating backup directory: $BACKUP_DIR"
                mkdir -p "$BACKUP_DIR"
                backed_up=true
            fi

            local backup_path="$BACKUP_DIR/$dotfile"
            mkdir -p "$(dirname "$backup_path")"

            echo "  ↳ Backing up: $dotfile"
            mv "$target" "$backup_path"
        fi
    done

    if [[ "$backed_up" == true ]]; then
        echo "✅ Backup completed: $BACKUP_DIR"
    else
        echo "✅ No existing dotfiles found to backup"
    fi
}

backup_dotfiles
