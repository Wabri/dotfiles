# Installation Scripts - Issues & Fixes

**Date**: 2026-04-14  
**Status**: Issues identified, fixes proposed

---

## Critical Issues

### 1. ❌ `stow.sh` - Incorrectly includes `install` directory

**Severity**: High  
**File**: `install/stow.sh:46`

**Issue**:
The `get_stow_packages()` function excludes the `scripts` directory but **not** the `install` directory. This causes the install scripts themselves to be stowed to the home directory, which is incorrect.

**Current Code** (line 44-48):
```bash
# Get all directories that contain dotfiles (exclude hidden dirs and scripts)
for dir in "$DOTFILES_DIR"/*; do
    if [[ -d "$dir" ]] && [[ ! "$(basename "$dir")" =~ ^\. ]] && [[ "$(basename "$dir")" != "scripts" ]]; then
        packages+=("$(basename "$dir")")
    fi
done
```

**Problem**:
- ✅ Excludes: hidden directories (`.git`, `.config`)
- ✅ Excludes: `scripts` directory
- ❌ Does NOT exclude: `install` directory

**Fix**:
```bash
# Get all directories that contain dotfiles (exclude hidden dirs, scripts, and install)
for dir in "$DOTFILES_DIR"/*; do
    local dirname="$(basename "$dir")"
    if [[ -d "$dir" ]] && [[ ! "$dirname" =~ ^\. ]] && [[ "$dirname" != "scripts" ]] && [[ "$dirname" != "install" ]]; then
        packages+=("$dirname")
    fi
done
```

**Impact**:
- Without fix: `~/install/` directory created with script symlinks
- With fix: Only actual dotfile packages are stowed

---

### 2. ⚠️ `packages.sh` - Missing dependency check for `column` command

**Severity**: Medium  
**File**: `install/packages.sh:130`

**Issue**:
The script uses `column` command to format package listing but doesn't check if it's installed.

**Current Code** (line 130):
```bash
printf '%s\n' "${packages[@]}" | column
```

**Problem**:
- If `column` is not installed, the command fails silently or shows raw output
- Not all minimal Linux installations include `column` (part of `util-linux`)

**Fix Option 1** - Graceful fallback:
```bash
if command -v column &> /dev/null; then
    printf '%s\n' "${packages[@]}" | column
else
    printf '  - %s\n' "${packages[@]}"
fi
```

**Fix Option 2** - Check at start:
```bash
check_dependencies() {
    if ! command -v column &> /dev/null; then
        log_warning "column command not found (install util-linux for better formatting)"
    fi
}
```

**Impact**:
- Minor: Only affects visual formatting of package list
- Workaround: User can still see packages, just not in columns

---

## Minor Issues

### 3. ℹ️ `post-install.sh` - Hardcoded ASDF version

**Severity**: Low  
**File**: `install/post-install.sh:151`

**Issue**:
ASDF version is hardcoded to `v0.14.1`, which may become outdated.

**Current Code** (line 151):
```bash
git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.14.1
```

**Recommendation**:
```bash
# Option 1: Use latest stable release
local ASDF_VERSION="v0.15.0"  # Update periodically

# Option 2: Use latest tag dynamically
local ASDF_VERSION=$(git ls-remote --tags https://github.com/asdf-vm/asdf.git | 
                     grep -o 'v[0-9]*\.[0-9]*\.[0-9]*$' | 
                     sort -V | 
                     tail -n1)

git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch "$ASDF_VERSION"
```

**Impact**:
- Users might install an older version of asdf
- asdf itself can be updated later with `asdf update`

---

### 4. ℹ️ No validation for `packages.txt` format

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

### 5. ℹ️ Missing `install.sh` in `.gitignore` or documentation

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

### 6. ℹ️ No main repository README documentation for install system

**Severity**: Low  
**File**: `README.md` (root)

**Issue**:
Main README doesn't document the installation system. Users might not know about `install.sh`.

**Fix**: Add installation section to main README (see issue #5)

---

## Feature Gaps (Enhancement Ideas)

### 7. 💡 No rollback mechanism

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

### 8. 💡 No diff/preview mode

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

### 9. 💡 No logging to file

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

### 10. 💡 No update mechanism

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

### Must Fix (Before Production Use)
- ✅ **Issue #1**: Exclude `install` directory from stow (CRITICAL)

### Should Fix (Nice to Have)
- ⚠️ **Issue #2**: Add `column` fallback or check
- ℹ️ **Issue #3**: Update ASDF version periodically

### Optional Enhancements
- Issues #7-10: Rollback, preview, logging, update mechanisms

---

## Priority Fix Script

Here's a quick patch for the critical issue:

```bash
# Fix issue #1
sed -i 's/!= "scripts"/!= "scripts" ]] \&\& [[ "$dirname" != "install"/' install/stow.sh
```

**Or manual fix**: Edit `install/stow.sh` line 46 as shown in Issue #1.

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
