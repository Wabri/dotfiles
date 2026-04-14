# Installation Scripts Documentation

Intelligent, cross-distribution dotfiles installation system with modular architecture.

## Table of Contents

- [Quick Start](#quick-start)
- [Architecture](#architecture)
- [Scripts Reference](#scripts-reference)
- [Requirements](#requirements)
- [Usage Examples](#usage-examples)
- [Troubleshooting](#troubleshooting)

---

## Quick Start

```bash
# Clone the repository
git clone https://github.com/Wabri/dotfiles.git
cd dotfiles

# Interactive installation (recommended for first-time users)
./install.sh

# Full automated installation
./install.sh --full

# Help and options
./install.sh --help
```

---

## Architecture

The installation system consists of a main orchestrator and four specialized modules:

```
install.sh              # Main orchestrator - manages installation flow
├── install/backup.sh   # Backs up existing dotfiles
├── install/packages.sh # Cross-distro package installation
├── install/stow.sh     # Symlinks dotfiles using GNU Stow
└── install/post-install.sh  # Post-installation configuration
```

### Design Principles

- **Modular**: Each script has a single, well-defined responsibility
- **Safe**: Automatic backups, confirmation prompts, validation checks
- **Flexible**: Interactive mode or fully automated
- **Cross-platform**: Supports multiple Linux distributions
- **User-friendly**: Colored output, clear messages, progress indicators

---

## Requirements

### Required Dependencies

- **git** - Version control (for cloning the repository)
- **stow** - GNU Stow for managing symlinks

### Optional Dependencies

- **column** - For formatted package listing (usually in `util-linux`)
- **fc-cache** - Font cache utility (usually in `fontconfig`)

### Supported Distributions

| Distribution | Package Manager | Status |
|-------------|----------------|--------|
| openSUSE (Tumbleweed/Leap) | zypper | ✅ Fully tested |
| Debian/Ubuntu | apt | ✅ Supported |
| Fedora/RHEL | dnf | ✅ Supported |
| Arch Linux | pacman | ✅ Supported |

---

## Scripts Reference

### 1. `install.sh` - Main Orchestrator

**Purpose**: Central entry point that coordinates the installation process.

**Features**:
- Interactive installation wizard
- Multiple installation modes
- Dependency validation
- Component orchestration

**Usage**:
```bash
./install.sh [OPTIONS]
```

**Options**:
| Option | Description |
|--------|-------------|
| `-h, --help` | Show help message |
| `-f, --full` | Full installation (packages + dotfiles + post-install) |
| `-d, --dotfiles-only` | Install dotfiles only (skip packages) |
| `-p, --packages-only` | Install packages only (skip dotfiles) |
| `-s, --skip-backup` | Skip backup of existing dotfiles |
| `-y, --yes` | Automatic yes to prompts |

**Installation Modes**:

1. **Interactive Mode** (default)
   ```bash
   ./install.sh
   ```
   - Guided installation with prompts
   - Choose components to install
   - Recommended for first-time users

2. **Full Installation**
   ```bash
   ./install.sh --full
   ```
   - Installs everything
   - Minimal interaction required

3. **Dotfiles Only**
   ```bash
   ./install.sh --dotfiles-only
   ```
   - Only symlinks configuration files
   - Useful for updating configs

4. **Packages Only**
   ```bash
   ./install.sh --packages-only
   ```
   - Only installs system packages
   - Useful for new system setup

5. **Custom Mode**
   - Select via interactive menu
   - Pick and choose components

---

### 2. `install/backup.sh` - Dotfiles Backup

**Purpose**: Creates timestamped backups of existing dotfiles before installation.

**What Gets Backed Up**:
- Shell configurations (`.zshrc`, `.tmux.conf`, `.aliases`, `.gitconfig`)
- Editor configs (`.config/nvim`)
- Window manager configs (sway, niri, i3, hyprland, gnome)
- Terminal emulators (kitty, alacritty, ghostty)
- Launchers and bars (waybar, rofi, wofi, fuzzel)
- Notification daemons (mako, dunst, swaync)

**Behavior**:
- Only backs up real files/directories (ignores symlinks)
- Creates backup directory: `~/.dotfiles_backup_YYYYMMDD_HHMMSS`
- Preserves directory structure
- Safe to run multiple times

**Manual Usage**:
```bash
./install/backup.sh
```

**Output Example**:
```
🔍 Checking for existing dotfiles...
📦 Creating backup directory: /home/user/.dotfiles_backup_20260414_143022
  ↳ Backing up: .zshrc
  ↳ Backing up: .config/nvim
✅ Backup completed: /home/user/.dotfiles_backup_20260414_143022
```

---

### 3. `install/packages.sh` - Package Installation

**Purpose**: Cross-distribution package installation from `packages.txt`.

**Features**:
- Auto-detects package manager
- Reads package list from `../packages.txt`
- Skips comments and empty lines
- Shows preview before installation
- Requires user confirmation

**Manual Usage**:
```bash
./install/packages.sh
```

**Package Manager Detection**:
```
zypper → openSUSE
apt    → Debian/Ubuntu
dnf    → Fedora/RHEL
pacman → Arch Linux
```

**packages.txt Format**:
```txt
# Comments start with #
neovim
git
stow

# Blank lines are ignored
tmux
zsh
```

**Security**:
- Prevents running as root (requires sudo for actual installation)
- Shows all packages before installation
- Requires explicit confirmation

---

### 4. `install/stow.sh` - Dotfiles Symlinking

**Purpose**: Manages symlinks for dotfiles using GNU Stow.

**Features**:
- Auto-discovers stowable packages
- Selective or full installation
- Three operation modes (stow/unstow/restow)
- Package listing

**Manual Usage**:
```bash
./install/stow.sh [OPTIONS] [PACKAGES...]
```

**Options**:
| Option | Description |
|--------|-------------|
| `-h, --help` | Show help message |
| `-u, --unstow` | Remove symlinks |
| `-r, --restow` | Recreate symlinks |
| `-l, --list` | List available packages |

**Examples**:
```bash
# Stow all packages
./install/stow.sh

# Stow specific packages
./install/stow.sh nvim zsh tmux

# List available packages
./install/stow.sh --list

# Remove symlinks for sway
./install/stow.sh --unstow sway

# Recreate symlinks for nvim (useful after updates)
./install/stow.sh --restow nvim
```

**How It Works**:
1. Scans dotfiles directory for subdirectories
2. Excludes special directories (`scripts`, `install`, hidden dirs)
3. Creates symlinks from `~` to dotfiles repo
4. Preserves directory structure

**Package Structure Example**:
```
nvim/
├── .config/
│   └── nvim/
│       ├── init.lua
│       └── lua/
│           └── plugins/
```

After stowing: `~/.config/nvim/init.lua` → `~/dotfiles/nvim/.config/nvim/init.lua`

---

### 5. `install/post-install.sh` - Post-Installation Tasks

**Purpose**: Automated post-installation configuration and setup.

**Tasks Performed**:

1. **Set Zsh as Default Shell**
   - Checks if zsh is installed
   - Adds zsh to `/etc/shells` if needed
   - Changes default shell via `chsh`

2. **Setup Neovim**
   - Verifies nvim config exists
   - Reminds about plugin installation (`:Lazy sync` or `:PackerSync`)

3. **Setup Tmux**
   - Installs TPM (Tmux Plugin Manager) if missing
   - Clones from `https://github.com/tmux-plugins/tpm`
   - Provides instructions for plugin installation

4. **Enable Systemd User Services**
   - Scans `~/.config/systemd/user/` for services
   - Interactively asks to enable each service
   - Uses `systemctl --user enable`

5. **Update Font Cache**
   - Runs `fc-cache -fv` to rebuild font cache
   - Required after installing new fonts

6. **Setup ASDF Version Manager**
   - Optionally installs asdf (v0.14.1)
   - Clones from official repository
   - User can skip if not needed

**Manual Usage**:
```bash
./install/post-install.sh
```

**Interactive Prompts**:
- All tasks run automatically except systemd services
- Systemd services require per-service confirmation
- ASDF installation is optional (user prompted)

---

## Usage Examples

### First-Time Installation on New System

```bash
# 1. Clone the repository
git clone https://github.com/Wabri/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Run full installation
./install.sh --full

# 3. Log out and back in
# 4. Install Neovim plugins
nvim
:Lazy sync

# 5. Install Tmux plugins
tmux
# Press: prefix + I
```

### Update Dotfiles on Existing System

```bash
cd ~/dotfiles
git pull

# Update configs without reinstalling packages
./install.sh --dotfiles-only --skip-backup

# Or just restow specific packages
./install/stow.sh --restow nvim zsh
```

### Install Only Packages (for new environment)

```bash
cd ~/dotfiles

# Install packages from packages.txt
./install.sh --packages-only
```

### Add/Remove Specific Configurations

```bash
# Remove sway configs
./install/stow.sh --unstow sway

# Add niri configs
./install/stow.sh niri

# List what's available
./install/stow.sh --list
```

### Test Before Full Installation

```bash
# 1. Check dependencies
git --version
stow --version

# 2. Preview packages
cat packages.txt

# 3. List available dotfile packages
./install/stow.sh --list

# 4. Do a dry run (backup only, no changes)
./install/backup.sh
```

---

## Troubleshooting

### Common Issues

#### 1. "GNU Stow is not installed"
```bash
# openSUSE
sudo zypper install stow

# Debian/Ubuntu
sudo apt install stow

# Fedora
sudo dnf install stow

# Arch
sudo pacman -S stow
```

#### 2. "Package manager not detected"
**Cause**: Unsupported distribution or missing package manager.

**Solution**: Manually install packages from `packages.txt` or add your package manager to `install/packages.sh`.

#### 3. Stow Conflicts
**Error**: `WARNING! stowing nvim would cause conflicts:`

**Cause**: Existing files/directories at target location.

**Solutions**:
```bash
# Option 1: Backup and retry
./install/backup.sh
./install/stow.sh --restow nvim

# Option 2: Remove existing files manually
rm -rf ~/.config/nvim
./install/stow.sh nvim
```

#### 4. Permission Denied
**Error**: `chsh: Permission denied`

**Solution**: Some systems require password for shell changes:
```bash
chsh -s $(which zsh)
# Enter your password when prompted
```

#### 5. Systemd Services Won't Start
**Cause**: Service dependencies not met or syntax errors.

**Debug**:
```bash
# Check service status
systemctl --user status service-name.service

# View logs
journalctl --user -u service-name.service

# Validate service file
systemd-analyze verify ~/.config/systemd/user/service-name.service
```

#### 6. Fonts Not Appearing
**Cause**: Font cache not updated.

**Solution**:
```bash
# Rebuild font cache
fc-cache -fv

# Verify fonts are installed
fc-list | grep "FontName"

# Restart applications
```

### Script-Specific Issues

#### packages.sh: Column command not found
```bash
# Install util-linux package
sudo zypper install util-linux  # openSUSE
sudo apt install bsdmainutils   # Debian/Ubuntu
```

#### stow.sh: Including 'install' directory
**Issue**: The `install` directory gets stowed (it shouldn't).

**Workaround**: Use selective stowing:
```bash
./install/stow.sh nvim zsh tmux  # Specify packages explicitly
```

#### post-install.sh: ASDF version outdated
**Issue**: Hardcoded version may be old.

**Solution**: Check latest version at https://github.com/asdf-vm/asdf/releases
```bash
# Manual installation with latest version
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0
```

### Getting Help

```bash
# Main script help
./install.sh --help

# Stow script help
./install/stow.sh --help
```

---

## File Structure Reference

```
dotfiles/
├── install.sh                    # Main orchestrator
├── packages.txt                  # Package list
├── README.md                     # Main repository README
├── install/
│   ├── README.md                 # This file
│   ├── backup.sh                 # Backup script
│   ├── packages.sh               # Package installer
│   ├── stow.sh                   # Stow manager
│   └── post-install.sh           # Post-install tasks
├── nvim/                         # Neovim configs (stow package)
│   └── .config/nvim/...
├── zsh/                          # Zsh configs (stow package)
│   ├── .zshrc
│   └── .config/zsh/...
├── tmux/                         # Tmux configs (stow package)
│   └── .tmux.conf
├── sway/                         # Sway WM configs (stow package)
│   └── .config/sway/...
├── niri/                         # Niri compositor configs (stow package)
│   └── .config/niri/...
└── [... other stow packages ...]
```

---

## Development

### Adding a New Package to Stow

1. Create directory in dotfiles root:
   ```bash
   mkdir -p mynewpackage/.config/mynewapp
   ```

2. Add configuration files:
   ```bash
   cp ~/.config/mynewapp/config.toml mynewpackage/.config/mynewapp/
   ```

3. Stow the package:
   ```bash
   ./install/stow.sh mynewpackage
   ```

4. (Optional) Add to backup list in `install/backup.sh`:
   ```bash
   DOTFILES_TO_BACKUP=(
       # ... existing entries ...
       ".config/mynewapp"
   )
   ```

### Adding Packages to packages.txt

1. Edit `packages.txt`:
   ```bash
   echo "package-name" >> packages.txt
   ```

2. Ensure package name works across distributions (or document distro-specific names)

### Modifying Installation Flow

Edit `install.sh` to change:
- Installation order (lines 265-287)
- Available modes (lines 159-193)
- Default behavior (lines 212-217)

---

## Security Considerations

- Scripts use `set -e` for fail-fast behavior
- Root execution is prevented (except via sudo when needed)
- Backups created before destructive operations
- User confirmation required for sensitive operations
- No automatic force-push or destructive git operations

---

## Contributing

When modifying scripts:
1. Maintain consistent logging style (log_info, log_success, log_warning, log_error)
2. Add user confirmations for destructive operations
3. Test on multiple distributions if changing package installation
4. Update this documentation
5. Check syntax: `bash -n script.sh`

---

## License

Part of Wabri's dotfiles repository. See main repository for license information.

---

## Changelog

- **2026-04-14**: Added documentation
- **2026-04-XX**: Added niri to backup list
- Earlier: Initial creation of modular installation system

---

**Last Updated**: 2026-04-14
