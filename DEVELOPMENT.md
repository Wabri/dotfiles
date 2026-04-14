# Development Notes

**Last Updated**: 2026-04-14

This document tracks development ideas, known limitations, and enhancement opportunities for the dotfiles system.

> **Note**: For release history, see [CHANGELOG.md](CHANGELOG.md)

---

## Implemented Features ✅

See [CHANGELOG.md](CHANGELOG.md) for full history:
- ✅ Exclude `install` directory from stow  
- ✅ Column command fallback  
- ✅ ASDF version management  
- ✅ Comprehensive documentation  
- ✅ Per-directory package management  
- ✅ Rollback mechanism  
- ✅ Preview/dry-run mode  
- ✅ Unified CLI tool  
- ✅ Fix packages.txt stowing with .stow-local-ignore  

---

## Future Enhancement Ideas

### Logging to File
**Priority**: Low  
**Complexity**: Easy

Keep installation output in a log file for debugging.

**Implementation**:
```bash
LOG_FILE="$HOME/.dotfiles_install_$(date +%Y%m%d_%H%M%S).log"
dotfiles install --full 2>&1 | tee "$LOG_FILE"
```

**Pros**:
- Useful for troubleshooting failed installations
- Can review what happened later

**Cons**:
- Terminal output is usually sufficient
- Adds file clutter in home directory
- Most users won't use it

**Recommendation**: Low priority - can be done manually with `tee` when needed

---

### Package Validation
**Priority**: Not Recommended  
**Complexity**: Medium

Validate packages exist before attempting installation.

**Implementation**:
```bash
validate_packages() {
    for pkg in "${packages[@]}"; do
        case "$pkg_manager" in
            zypper) zypper search -x "$pkg" &>/dev/null || invalid+=("$pkg") ;;
            apt) apt-cache show "$pkg" &>/dev/null || invalid+=("$pkg") ;;
        esac
    done
}
```

**Pros**:
- Catch typos before installation
- Show which packages are invalid

**Cons**:
- Adds 1-2 minutes to check ~120 packages
- Network calls for each package
- Breaks if repos not updated
- Error during install is clear enough

**Recommendation**: Not worth the overhead - better to fail fast during install

---

### Cross-Platform Package Names
**Priority**: Medium  
**Complexity**: High

Handle different package names across distributions.

**Problem**: Some packages have different names:
- openSUSE: `nodejs`, Debian: `nodejs`, Arch: `nodejs` ✅ Same
- openSUSE: `python3`, Debian: `python3`, Arch: `python` ❌ Different

**Potential Solutions**:
1. Distribution-specific packages.txt files
2. Mapping file (package-name → distro-specific-name)
3. Documentation noting differences

**Recommendation**: Document known differences, users can customize packages.txt for their distro

---

### Plugin Manager for Additional Features
**Priority**: Low  
**Complexity**: High

Allow users to add custom commands to the `dotfiles` CLI.

**Example**:
```bash
dotfiles plugin install dotfiles-sync
dotfiles sync  # Custom command from plugin
```

**Recommendation**: Over-engineering for a personal dotfiles repo

---

## Known Limitations

### Distribution Support
- **Fully tested**: openSUSE Tumbleweed
- **Supported**: Debian/Ubuntu, Fedora, Arch
- **Untested**: Other distributions

### Stow Conflicts
- Existing files/directories prevent stowing
- Solution: Use `dotfiles backup` first, or remove conflicting files

### Package Names
- Some packages may not exist in all distribution repositories
- Users need to customize packages.txt for their distro
- Flatpak apps listed separately in packages.flatpak.txt

### Git Dependency
- `dotfiles update` requires git repository
- Won't work if dotfiles downloaded as zip

---

## Architecture Notes

### Why Bash?
- Universal on Linux systems
- No runtime dependencies
- Easy to read and modify
- Good enough for this use case

### Why GNU Stow?
- Simple, robust symlink management
- Handles directory structures automatically
- Easy to unstow/restow
- Been around forever, well-tested

### Module Structure
```
dotfiles (CLI) → install.sh (orchestrator) → specialized scripts
                                           ├─ backup.sh
                                           ├─ packages.sh
                                           ├─ stow.sh
                                           └─ post-install.sh
```

**Benefits**:
- Each script has single responsibility
- Can be used independently
- Easy to test and maintain
- CLI provides unified interface

---

## Testing Guidelines

### Quick Tests
```bash
# Syntax checks
bash -n dotfiles
bash -n install.sh
bash -n install/*.sh

# Functionality tests
dotfiles list
dotfiles preview vim
dotfiles status
```

### Full Testing
```bash
# Test in a container (recommended for destructive tests)
docker run -it --rm opensuse/tumbleweed bash
zypper install -y git stow
git clone https://github.com/Wabri/dotfiles.git
cd dotfiles
./install-cli.sh
dotfiles install --full
```

### Manual Test Checklist
- [ ] CLI tool works from any directory
- [ ] Stow excludes packages.txt (check .stow-local-ignore)
- [ ] Preview mode shows changes correctly
- [ ] Backup creates timestamped directory
- [ ] Rollback restores files correctly
- [ ] Package installation works on target distro
- [ ] Post-install tasks complete successfully
- [ ] Update pulls and restows correctly

---

## Code Style Guidelines

### Shell Script Best Practices
- Use `set -e` for fail-fast behavior
- Use consistent logging: `log_info`, `log_success`, `log_warning`, `log_error`
- Quote variables: `"$variable"` not `$variable`
- Use `[[ ]]` for conditions, not `[ ]`
- Meaningful variable names (no single letters unless loop counters)

### Commit Message Format
```
<type>(<scope>): <subject>

<body>

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

**Types**: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`

**Examples**:
- `feat(nvim): add LSP configuration`
- `fix(stow): exclude packages.txt from being stowed`
- `docs(readme): update installation instructions`

---

## Performance Considerations

### Package Installation
- Installing 120 packages takes 5-15 minutes depending on:
  - Network speed
  - Package manager
  - Whether packages are cached

### Stow Operations
- Very fast (milliseconds)
- Bottleneck is disk I/O, not computation

### Git Operations  
- `dotfiles update` takes 1-10 seconds depending on changes

---

## Security Considerations

- Scripts prevent running as root (except via sudo when needed)
- Backups created before destructive operations
- User confirmation for risky operations
- No automatic force-push or destructive git operations
- No secrets in repository (use .gitignore)

---

**Last Updated**: 2026-04-14  
**Maintainer**: Wabri
