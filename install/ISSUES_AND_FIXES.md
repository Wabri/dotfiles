# Installation Scripts - Issues & Fixes

**Date**: 2026-04-14  
**Status**: Active issues requiring fixes

> **Note**: Fixed issues are documented in CHANGELOG.md

---

## Issues To Fix



### 1. ℹ️ No validation for `packages.txt` format

**Severity**: Low  
**File**: `install/packages.sh`

**Issue**:
No validation that packages in `packages.txt` exist or are named correctly for the detected package manager.

**Potential Problems**:
- Package names may differ across distributions
  - openSUSE: `neovim`
  - Ubuntu: `neovim`
  - Arch: `neovim`
  - Some use different names: `nodejs` vs `node`, `ripgrep` vs `rg`
- Typos in `packages.txt` cause installation failures

**Enhancement Ideas**:
```bash
# Add package validation (optional)
validate_packages() {
    local pkg_manager="$1"
    shift
    local packages=("$@")
    local invalid=()
    
    for pkg in "${packages[@]}"; do
        case "$pkg_manager" in
            zypper)
                zypper search -x "$pkg" &>/dev/null || invalid+=("$pkg")
                ;;
            apt)
                apt-cache show "$pkg" &>/dev/null 2>&1 || invalid+=("$pkg")
                ;;
        esac
    done
    
    if [[ ${#invalid[@]} -gt 0 ]]; then
        log_warning "Unknown packages: ${invalid[*]}"
        read -p "Continue anyway? [y/N] " -n 1 -r
        [[ ! $REPLY =~ ^[Yy]$ ]] && exit 0
    fi
}
```

**Impact**:
- Would catch package name errors before attempting installation
- Adds significant execution time (checking ~120 packages)

**Recommendation**: Keep current behavior (fail on invalid package during install)

---

---

## Feature Gaps (Enhancement Ideas)

### 2. 💡 No rollback mechanism

**Enhancement**: Add ability to rollback to backup

**Implementation**:
```bash
# Add to install.sh
rollback() {
    local backup_dir="$1"
    
    if [[ ! -d "$backup_dir" ]]; then
        log_error "Backup directory not found: $backup_dir"
        exit 1
    fi
    
    log_warning "This will restore files from: $backup_dir"
    read -p "Continue? [y/N] " -n 1 -r
    echo ""
    
    [[ ! $REPLY =~ ^[Yy]$ ]] && exit 0
    
    # Unstow all packages
    ./install/stow.sh --unstow
    
    # Restore backup
    cp -r "$backup_dir"/* "$HOME/"
    
    log_success "Rollback complete"
}

# Usage: ./install.sh --rollback ~/.dotfiles_backup_20260414_143022
```

---

### 3. 💡 No diff/preview mode

**Enhancement**: Show what will change before applying

**Implementation**:
```bash
# Add to stow.sh
preview_stow() {
    local package="$1"
    stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" -n -v "$package"
}

# Usage: ./install/stow.sh --preview nvim
```

---

### 4. 💡 No logging to file

**Enhancement**: Keep installation log for debugging

**Implementation**:
```bash
# Add to install.sh
LOG_FILE="$HOME/.dotfiles_install_$(date +%Y%m%d_%H%M%S).log"

# Redirect all output
main() {
    # ... existing code ...
} 2>&1 | tee "$LOG_FILE"
```

---

### 5. 💡 No update mechanism

**Enhancement**: Add `./install.sh --update` to pull changes and restow

**Implementation**:
```bash
update_dotfiles() {
    log_info "Updating dotfiles from git..."
    git pull
    
    log_info "Restowing all packages..."
    ./install/stow.sh --restow
    
    log_success "Update complete"
}

# Add to case statement in main()
--update)
    update_dotfiles
    exit 0
    ;;
```

---

## Summary

### Fixed ✅
- ~~Exclude `install` directory from stow~~ - FIXED
- ~~Add `column` fallback~~ - FIXED  
- ~~Update ASDF version~~ - FIXED
- ~~Add installation docs to main README~~ - FIXED

See CHANGELOG.md for details.

### Remaining Issues

#### Optional Enhancements
- **Issues #2-5**: Rollback, preview, logging, update mechanisms
- **Issue #1**: Package validation (not recommended - adds overhead)

---

## Testing Checklist

After applying fixes:

- [ ] Run `bash -n install.sh` (syntax check)
- [ ] Run `bash -n install/*.sh` (syntax check all)
- [ ] Test `./install/stow.sh --list` (should NOT show "install")
- [ ] Test `./install/packages.sh` without `column` installed
- [ ] Test full installation in VM/container
- [ ] Verify backup creation works
- [ ] Verify rollback process (if implemented)

---

**Generated**: 2026-04-14  
**Last Review**: 2026-04-14
