# Installation Scripts Changelog

## [Unreleased] - 2026-04-14

### Added
- ✨ Comprehensive documentation in `install/README.md`
- 📋 Issue tracker and fixes documentation in `install/ISSUES_AND_FIXES.md`
- 📝 This changelog

### Changed
- 🔄 **post-install.sh**: Updated ASDF version from v0.14.1 to v0.18.1
  - Made version configurable via variable
  - Added comment with update instructions
  - Version now displayed during installation

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

### Testing
- ✅ Syntax validation passed for all scripts
- ✅ Verified `install` directory no longer appears in stow package list
- ✅ Tested column fallback behavior

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
