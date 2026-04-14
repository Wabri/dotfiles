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

### 2. ℹ️ Missing `install.sh` in `.gitignore` or documentation

**Severity**: Very Low  
**File**: N/A

**Observation**:
The main `install.sh` is at the repository root, which is correct, but there's no mention of it in the main README.

**Enhancement**:
Add installation instructions to main `README.md`:
```markdown
## Installation

See [install/README.md](install/README.md) for detailed instructions.

Quick start:
\`\`\`bash
./install.sh --full
\`\`\`
```

---

## Documentation Issues

### 3. ℹ️ No main repository README documentation for install system

**Severity**: Low  
**File**: `README.md` (root)

**Issue**:
Main README doesn't document the installation system. Users might not know about `install.sh`.

**Fix**: Add installation section to main README (see issue #5)

---

## Feature Gaps (Enhancement Ideas)

### 4. 💡 No rollback mechanism

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

### 5. 💡 No diff/preview mode

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

### 6. 💡 No logging to file

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

### 7. 💡 No update mechanism

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

See CHANGELOG.md for details.

### Remaining Issues

#### Should Fix (Nice to Have)
- **Issue #2-3**: Add installation docs to main README

#### Optional Enhancements
- **Issues #4-7**: Rollback, preview, logging, update mechanisms

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
