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

# Install dotfiles (stow configs)
dotfiles install

# Install packages for specific tools only
dotfiles packages nvim zsh tmux

# Run post-installation tasks (ASDF, etc)
dotfiles post-install
```

**Using the CLI:**
```bash
dotfiles help                    # Show all commands
dotfiles stow nvim zsh           # Stow specific configs
dotfiles preview sway            # Preview changes before applying (shows file diffs)
dotfiles packages nvim zsh       # Install packages for specific tools
dotfiles status                  # Check repository status
dotfiles diff                    # Show differences between local and remote
dotfiles commit "message"        # Stage all changes and commit
dotfiles push                    # Push local commits to remote
dotfiles update                  # Pull latest changes and restow
```

## Documentation

- **[install/README.md](install/README.md)** - Detailed installation guide
- **[CHANGELOG.md](CHANGELOG.md)** - Release history and changes
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - How to contribute
- **[DEVELOPMENT.md](DEVELOPMENT.md)** - Development notes and ideas

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
