# Installation Scripts Changelog

## [Unreleased] - 2026-04-14

### Added
- 💡 **Package suggestions on stow**: When stowing a package, suggest installing dependencies
  - Shows message: "Package 'X' has dependencies. Install them with: dotfiles packages X"
  - Allows selective installation (e.g., niri OR sway, not both)
  - Reduces system bloat by not auto-installing all packages

### Removed
- ❌ **Removed `--full` installation option**: Too invasive, installed all packages for all configs
- ❌ **Removed `--packages-only` option**: Package installation is now always opt-in via `dotfiles packages`
- ❌ **Simplified interactive installation**: Now only asks for confirmation, no complex menus

### Added (Previously)
- ✨ Comprehensive documentation in `install/README.md`
- 📋 Issue tracker and fixes documentation in `install/ISSUES_AND_FIXES.md`
- 📝 This changelog
- 🔄 **Rollback mechanism**: `./install.sh --rollback <backup-dir>`
  - Restore dotfiles from any backup directory
  - Automatically unstows current dotfiles first
  - Shows backup info and confirms before proceeding
  - Lists available backups if none specified
- 👁️ **Preview/dry-run mode**: `./install/stow.sh -n <package>`
  - See what will change before actually stowing
  - **Enhanced**: Shows actual file content diffs (unified diff format)
  - Color-coded diff output (green for additions, red for deletions)
  - Shows preview of new files (first 10 lines)
  - Indicates already-symlinked files and their targets
  - Handles conflicts gracefully by manually finding files
  - Highlights warnings and conflicts
  - Safe way to test before applying changes
- 🔍 **Repository diff command**: `dotfiles diff`
  - Compare local dotfiles with remote repository
  - Shows commits ahead of remote (not yet pushed)
  - Shows commits behind remote (not yet pulled)
  - Displays file changes statistics
  - Automatically fetches latest remote state
- 💾 **Commit command**: `dotfiles commit [message]`
  - Stage all changes and commit in one command
  - Prompts for commit message if not provided
  - Shows what will be committed before committing
  - Displays commit summary after success
- 📤 **Push command**: `dotfiles push`
  - Push local commits to remote repository
  - Requires clean working tree (no uncommitted changes)
  - Shows what will be pushed before pushing
  - Confirms successful push with commit count
- 🚀 **Unified CLI tool**: `dotfiles` command
  - Single command for all operations
  - Installed to PATH via `./install-cli.sh`
  - Subcommands: install, stow, unstow, preview, packages, backup, rollback, update, status
  - Works from anywhere in the system
  - Git-style interface (like `git`, `docker`, etc.)

### Changed
- 🔄 **post-install.sh**: Updated ASDF version from v0.14.1 to v0.18.1
  - Made version configurable via variable
  - Added comment with update instructions
  - Version now displayed during installation
- 📝 **README.md**: Added installation section to main README
  - Quick start instructions
  - Link to detailed documentation
  - Requirements and features overview
- 🎯 **Package management restructure**: Moved from single packages.txt to per-directory structure
  - **packages.txt** (root): Core system packages (80+ packages)
  - **<dir>/packages.txt**: Directory-specific packages (e.g., nvim/packages.txt, sway/packages.txt)
  - **packages.flatpak.txt**: Flatpak applications (separate from system packages)
  - **packages.sh**: Now supports selective installation (`./install/packages.sh nvim zsh`)
  - Install all with `--all`, core-only by default, or specify directories
  - Automatic deduplication of packages

### Fixed
- 🐛 **CRITICAL**: `stow.sh` now correctly excludes `install` directory from stowable packages
  - **Issue**: The `install` directory was being symlinked to `~/install/` 
  - **Fix**: Added `install` to exclusion list alongside `scripts` directory
  - **Impact**: Prevents installation scripts from being stowed into home directory
  
- 🐛 **MEDIUM**: `packages.sh` now gracefully handles missing `column` command
  - **Issue**: Script would fail if `column` utility was not installed
  - **Fix**: Added fallback to simple bullet list format when `column` is unavailable
  - **Impact**: Script now works on minimal Linux installations

### Changed
- 🔧 Made all install scripts executable (chmod +x)
  - `install/backup.sh`
  - `install/packages.sh`
  - `install/post-install.sh`
  - `install/stow.sh`

### Technical Details

#### Fix #1: Exclude `install` directory from stow
```diff
- # Get all directories that contain dotfiles (exclude hidden dirs and scripts)
+ # Get all directories that contain dotfiles (exclude hidden dirs, scripts, and install)
  for dir in "$DOTFILES_DIR"/*; do
-     if [[ -d "$dir" ]] && [[ ! "$(basename "$dir")" =~ ^\. ]] && [[ "$(basename "$dir")" != "scripts" ]]; then
-         packages+=("$(basename "$dir")")
+     local dirname="$(basename "$dir")"
+     if [[ -d "$dir" ]] && [[ ! "$dirname" =~ ^\. ]] && [[ "$dirname" != "scripts" ]] && [[ "$dirname" != "install" ]]; then
+         packages+=("$dirname")
      fi
  done
```

#### Fix #2: Column command fallback
```diff
  log_warning "The following packages will be installed:"
- printf '%s\n' "${packages[@]}" | column
+ if command -v column &> /dev/null; then
+     printf '%s\n' "${packages[@]}" | column
+ else
+     printf '  - %s\n' "${packages[@]}"
+ fi
```

#### Enhancement: Preview mode with content diffs
**Location**: `install/stow.sh:preview_package()`

The preview function now shows actual file content differences instead of just symlink operations:

```bash
# Parse stow output to find files that would be linked
# If stow fails due to conflicts, manually find files with find command
# For each file:
if [[ -f "$target_file" ]] && [[ ! -L "$target_file" ]]; then
    # Show unified diff with colored output
    diff -u "$target_file" "$source_file" | tail -n +3 | while IFS= read -r diffline; do
        # Color code: red for -, green for +, blue for @@
    done
elif [[ -L "$target_file" ]]; then
    # Show current symlink target
else
    # Show preview of new file (first 10 lines)
fi
```

Key improvements:
- Uses `diff -u` for unified diff format
- Handles conflicts by falling back to `find` command
- Escapes regex metacharacters in pattern matching (`^\-` and `^\+`)
- Excludes `.stow-local-ignore` and `packages.txt` from preview

#### New feature: Repository diff command
**Location**: `dotfiles:cmd_diff()`

```bash
git fetch --quiet 2>/dev/null || true
git log @{upstream}..HEAD --oneline    # Commits ahead
git log HEAD..@{upstream} --oneline    # Commits behind  
git diff @{upstream}..HEAD --stat      # File changes
```

#### New feature: Commit command
**Location**: `dotfiles:cmd_commit()`

Simplified git workflow - stage all changes and commit in one command:

```bash
# Check for changes (both tracked and untracked)
git diff-index --quiet HEAD -- && git ls-files --others --exclude-standard

# Show changes to be committed
git status --short

# Stage all changes
git add -A

# Commit with message (from argument or prompt)
git commit -m "$message"
```

Usage:
- `dotfiles commit "message"` - Provide message as argument
- `dotfiles commit` - Interactive prompt for message

#### New feature: Push command
**Location**: `dotfiles:cmd_push()`

Push local commits to remote with safety checks:

```bash
# Require clean working tree
git diff-index --quiet HEAD --

# Fetch and check ahead count
git fetch --quiet
git rev-list --count @{upstream}..HEAD

# Show what will be pushed
git log @{upstream}..HEAD --oneline

# Push to remote
git push
```

#### Implementation: Package suggestions on stow
**Location**: `install/stow.sh:stow_package()`

After successfully stowing a package, check for packages.txt and suggest installation:

```bash
if stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" -v "$package" 2>&1 | grep -q "LINK"; then
    log_success "Stowed: $package"
    
    # Check if package has dependencies
    if [[ -f "$DOTFILES_DIR/$package/packages.txt" ]]; then
        echo ""
        log_info "Package '$package' has dependencies"
        echo "  Install them with: dotfiles packages $package"
        echo ""
    fi
fi
```

**Workflow change**:
- Old: `./install.sh --full` → installs ALL packages for ALL configs
- New: `dotfiles install` → stow configs only, suggests packages
- New: `dotfiles packages nvim zsh` → install only needed packages

### Testing
- ✅ Syntax validation passed for all scripts
- ✅ Verified `install` directory no longer appears in stow package list
- ✅ Tested column fallback behavior
- ✅ Enhanced preview mode shows actual file content diffs
- ✅ Preview mode handles conflicts gracefully
- ✅ Repository diff command shows correct ahead/behind status
- ✅ Commit command stages all changes and creates commit
- ✅ Commit command prompts for message when not provided
- ✅ Push command successfully pushes to remote
- ✅ Push command requires clean working tree
- ✅ Package suggestion appears when stowing packages with dependencies
- ✅ Interactive install simplified (no complex menus)
- ✅ --full option removed, install.sh only stows configs

---

## [1.0.0] - 2026-04-XX (Approximate)

### Added
- Initial modular installation system
- Main orchestrator: `install.sh`
- Backup script: `install/backup.sh`
- Package installer: `install/packages.sh`
- Stow manager: `install/stow.sh`
- Post-install tasks: `install/post-install.sh`
- Cross-distribution support (zypper, apt, dnf, pacman)
- Interactive and automated installation modes
- Colored logging output
- Systemd user service management
- ASDF version manager setup
- Tmux plugin manager (TPM) installation
- Font cache updating

### Features
- Automatic package manager detection
- Timestamped dotfile backups
- Selective package installation
- Stow/unstow/restow operations
- GNU Stow integration for symlink management
- Post-installation automation (shell change, plugin setup, etc.)

---

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2026-04-XX | Initial release of modular installation system |
| 1.0.1 | 2026-04-14 | Bug fixes and documentation |

---

## Upgrade Notes

### From pre-1.0.1 to 1.0.1

If you've already run the installation scripts:

1. **Check for stowed install directory**:
   ```bash
   ls -la ~/install/
   ```
   
   If this directory exists and contains symlinks to installation scripts, remove it:
   ```bash
   rm ~/install
   ```

2. **Update your local repository**:
   ```bash
   cd ~/dotfiles
   git pull
   ```

3. **No other action needed** - the fixes are automatic on next run

---

## Known Issues

See `install/ISSUES_AND_FIXES.md` for complete list.

### Minor Issues (Non-breaking)
- ASDF version hardcoded to v0.14.1 (can be updated manually)
- No package name validation across distributions
- No rollback mechanism for failed installations

### Enhancement Ideas
- Add `--update` flag to pull and restow
- Add `--rollback` to restore from backup
- Add `--preview` to show what will change
- Add installation logging to file

---

## Contributing

When making changes to installation scripts:

1. Update this changelog
2. Test on at least one distribution
3. Validate syntax: `bash -n script.sh`
4. Update documentation if behavior changes
5. Follow existing logging conventions

---

**Format**: Based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)  
**Versioning**: Semantic Versioning (Major.Minor.Patch)
