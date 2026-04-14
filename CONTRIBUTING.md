# Contributing to Wabri's Dotfiles

Thanks for your interest in contributing! This document provides guidelines for contributing to this dotfiles repository.

## Philosophy

This dotfiles system follows these principles:
- **Modular**: Each tool has its own directory
- **Safe**: Automatic backups, preview mode, rollback capability
- **Cross-platform**: Support multiple Linux distributions
- **User-friendly**: Clear output, good documentation
- **Simple**: Avoid over-engineering, keep it maintainable

## Development Setup

```bash
# Clone the repository
git clone https://github.com/Wabri/dotfiles.git
cd dotfiles

# Install the CLI tool
./install-cli.sh

# Test your changes
dotfiles preview <package>
```

## Project Structure

```
dotfiles/
├── dotfiles                   # Main CLI tool
├── install-cli.sh             # CLI installer
├── install.sh                 # Installation orchestrator
├── packages.txt               # Core system packages
├── packages.flatpak.txt       # Flatpak applications
├── install/                   # Installation scripts
│   ├── backup.sh              # Backup existing dotfiles
│   ├── packages.sh            # Package installation
│   ├── stow.sh                # Symlink management
│   └── post-install.sh        # Post-installation tasks
├── <tool>/                    # Per-tool directories
│   ├── .config/<tool>/...     # Tool configuration
│   ├── packages.txt           # Tool-specific packages
│   └── .stow-local-ignore     # Files to not stow
└── docs/
    ├── README.md              # Main documentation
    ├── CHANGELOG.md           # Release history
    ├── CONTRIBUTING.md        # This file
    └── DEVELOPMENT.md         # Development notes
```

## Adding a New Tool Configuration

1. **Create the directory structure**:
   ```bash
   mkdir -p mytool/.config/mytool
   ```

2. **Add configuration files**:
   ```bash
   cp ~/.config/mytool/* mytool/.config/mytool/
   ```

3. **Create packages.txt** (if needed):
   ```bash
   echo "mytool" > mytool/packages.txt
   ```

4. **Create .stow-local-ignore**:
   ```bash
   echo "packages.txt" > mytool/.stow-local-ignore
   ```

5. **Test it**:
   ```bash
   dotfiles preview mytool
   dotfiles stow mytool
   ```

6. **Commit**:
   ```bash
   git add mytool/
   git commit -m "feat(mytool): add mytool configuration"
   ```

## Making Changes to Installation Scripts

### Before You Start
1. Read the existing code
2. Check `DEVELOPMENT.md` for known issues
3. Test on a clean system if possible

### Testing Your Changes
```bash
# Syntax check
bash -n install.sh
bash -n install/packages.sh
bash -n install/stow.sh

# Test specific functionality
dotfiles preview <package>
dotfiles list

# Test in a container (recommended)
docker run -it --rm opensuse/tumbleweed bash
```

### Code Style
- Use `set -e` for fail-fast behavior
- Use consistent logging functions: `log_info`, `log_success`, `log_warning`, `log_error`
- Add comments for non-obvious logic
- Use meaningful variable names
- Follow existing patterns in the codebase

### Commit Messages
Follow conventional commits format:
```
<type>(<scope>): <subject>

<body>

Co-Authored-By: Name <email>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance

**Examples**:
```
feat(nvim): add LSP configuration
fix(stow): exclude packages.txt from being stowed
docs(readme): update installation instructions
refactor(packages): improve package manager detection
```

## Package Management

### Adding Packages

**Core packages** (always installed):
```bash
echo "package-name" >> packages.txt
```

**Tool-specific packages**:
```bash
echo "package-name" >> <tool>/packages.txt
```

**Flatpak applications**:
```bash
echo "com.example.App" >> packages.flatpak.txt
```

### Package Naming
- Use the package name from the distribution's repository
- Test on multiple distributions if possible
- Document in comments if package names differ between distros

## Documentation

### When to Update Documentation
- **README.md**: User-facing changes, new features
- **CHANGELOG.md**: All notable changes (features, fixes, breaking changes)
- **DEVELOPMENT.md**: Development notes, known issues, enhancement ideas
- **install/README.md**: Changes to installation system

### Documentation Style
- Use clear, concise language
- Include examples
- Use code blocks with syntax highlighting
- Keep formatting consistent
- Update the "Last Updated" date

## Pull Request Process

1. **Fork the repository** (if not a collaborator)
2. **Create a feature branch**: `git checkout -b feature/my-feature`
3. **Make your changes** following the guidelines above
4. **Test thoroughly** - at least run syntax checks
5. **Update documentation** - README, CHANGELOG, etc.
6. **Commit with clear messages**
7. **Push to your fork**: `git push origin feature/my-feature`
8. **Open a Pull Request** with:
   - Clear description of changes
   - Why the change is needed
   - How you tested it
   - Screenshots/output if applicable

## Questions?

- Check `DEVELOPMENT.md` for known issues
- Read the code - it's well-commented
- Open an issue for discussion

## License

By contributing, you agree that your contributions will be licensed under the same license as this project.
