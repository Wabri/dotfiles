# Wabri's Dotfiles

***Forever work in progress***

This repository contains my personal dotfiles and configuration files for various applications and tools I use daily. The goal is to maintain a clean, efficient, and personalized development environment.

## Installation

This repository includes an intelligent installation system with automatic backups and cross-distribution support.

**Quick start:**
```bash
# Clone the repository
git clone https://github.com/Wabri/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install the CLI (adds 'dotfiles' command to PATH)
./install-cli.sh

# Interactive installation (recommended)
dotfiles install

# Or full automated installation
dotfiles install --full
```

**Using the CLI:**
```bash
dotfiles help                    # Show all commands
dotfiles stow nvim zsh           # Stow specific configs
dotfiles preview sway            # Preview changes before applying
dotfiles packages nvim zsh       # Install packages for specific tools
dotfiles update                  # Pull latest changes and restow
dotfiles status                  # Check repository status
```

**For detailed documentation**, see [install/README.md](install/README.md)

### Requirements
- `git` and `stow` (required)
- Supported distributions: openSUSE, Debian/Ubuntu, Fedora, Arch Linux

### What's included
- 🖥️ Window managers: niri, sway, hyprland, i3wm, gnome
- 💻 Terminals: ghostty, alacritty, kitty
- 🐚 Shells: zsh, bash with custom configurations
- ✏️ Editor: Neovim with extensive plugin setup
- 🛠️ Development tools: tmux, git, asdf, and more
- 🎨 UI components: waybar, rofi, wofi, fuzzel, mako, dunst
