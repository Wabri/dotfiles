# Wabri's Dotfiles

***Forever work in progress***

This repository contains my personal dotfiles and configuration files for various applications and tools I use daily. The goal is to maintain a clean, efficient, and personalized development environment.

## Installation

This repository includes an intelligent installation system with cross-distribution support.

**Quick start:**
```bash
# Clone the repository
git clone https://github.com/Wabri/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install the CLI (adds 'dotfiles' command to PATH)
./install-cli.sh

# Stow specific configs
dotfiles stow nvim zsh

# Install packages for the configs you stowed
dotfiles packages nvim zsh

# Run setup tasks (zsh, asdf, etc)
dotfiles setup
```

**Using the CLI:**
```bash
dotfiles help                    # Show all commands
dotfiles stow nvim zsh           # Stow specific configs
dotfiles preview sway            # Preview changes before applying (shows file diffs)
dotfiles packages nvim zsh       # Install packages for specific tools
dotfiles setup                   # Run setup tasks (zsh, asdf, etc)
dotfiles status                  # Check repository status
dotfiles diff                    # Show differences between local and remote
dotfiles commit "message"        # Stage all changes and commit
dotfiles push                    # Push local commits to remote
dotfiles update                  # Pull latest changes and restow
```

## Contributing

**Adding a new tool configuration:**
```bash
# 1. Create directory structure
mkdir -p mytool/.config/mytool

# 2. Add your config files
cp ~/.config/mytool/* mytool/.config/mytool/

# 3. Add packages (optional)
echo "mytool" > mytool/packages.txt

# 4. Exclude packages.txt from stowing
echo "packages.txt" > mytool/.stow-local-ignore

# 5. Test it
dotfiles preview mytool
dotfiles stow mytool
```

**Making changes:**
- Use `dotfiles preview` before stowing
- Test on a clean system if possible
- Keep commit messages clear and descriptive

## Development

**Architecture:**
- **Why Bash?** Universal on Linux, no runtime dependencies, easy to read/modify
- **Why GNU Stow?** Simple symlink management, handles directories automatically, battle-tested
- **Module structure:** CLI → install.sh → specialized scripts (packages.sh, stow.sh, setup.sh)

**Code style:**
- Use `set -e` for fail-fast behavior
- Consistent logging: `log_info`, `log_success`, `log_warning`, `log_error`
- Quote variables: `"$variable"` not `$variable`
- Use `[[ ]]` for conditions, not `[ ]`

**Known limitations:**
- Fully tested on openSUSE Tumbleweed; supported on Debian/Ubuntu, Fedora, Arch
- Existing files prevent stowing (remove them manually or use `dotfiles unstow` first)
- Some packages may not exist in all distro repositories

## Requirements
- `git` and `stow` (required)
- Supported distributions: openSUSE, Debian/Ubuntu, Fedora, Arch Linux

### What's included
- 🖥️ Window managers: niri, sway, hyprland, i3wm, gnome
- 💻 Terminals: ghostty, alacritty, kitty
- 🐚 Shells: zsh, bash with custom configurations
- ✏️ Editor: Neovim with extensive plugin setup
- 🛠️ Development tools: tmux, git, asdf, and more
- 🎨 UI components: waybar, rofi, wofi, fuzzel, mako, dunst
