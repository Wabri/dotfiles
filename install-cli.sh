#!/usr/bin/env bash

# Install dotfiles CLI to PATH

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_CLI="$SCRIPT_DIR/dotfiles"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

echo ""
log_info "Installing dotfiles CLI..."
echo ""

# Check if dotfiles script exists
if [[ ! -f "$DOTFILES_CLI" ]]; then
    echo "Error: dotfiles script not found at $DOTFILES_CLI"
    exit 1
fi

# Make it executable
chmod +x "$DOTFILES_CLI"

# Determine installation directory
if [[ -d "$HOME/.local/bin" ]]; then
    INSTALL_DIR="$HOME/.local/bin"
elif [[ -d "$HOME/bin" ]]; then
    INSTALL_DIR="$HOME/bin"
else
    log_info "Creating ~/.local/bin directory"
    mkdir -p "$HOME/.local/bin"
    INSTALL_DIR="$HOME/.local/bin"
fi

# Create symlink
SYMLINK="$INSTALL_DIR/dotfiles"

if [[ -L "$SYMLINK" ]]; then
    log_warning "Symlink already exists, removing old one"
    rm "$SYMLINK"
elif [[ -f "$SYMLINK" ]]; then
    log_warning "File exists at $SYMLINK, backing up to ${SYMLINK}.backup"
    mv "$SYMLINK" "${SYMLINK}.backup"
fi

ln -s "$DOTFILES_CLI" "$SYMLINK"
log_success "Created symlink: $SYMLINK -> $DOTFILES_CLI"

# Check if directory is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    log_warning "$INSTALL_DIR is not in your PATH"
    log_info "Add it to your shell configuration:"
    echo ""
    echo "  # For bash (~/.bashrc):"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
    echo "  # For zsh (~/.zshrc):"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
    log_info "Then restart your shell or run: source ~/.zshrc"
else
    log_success "$INSTALL_DIR is in your PATH"
fi

echo ""
log_success "Installation complete!"
echo ""
log_info "Try it out:"
echo "  dotfiles --version"
echo "  dotfiles help"
echo "  dotfiles status"
echo ""
