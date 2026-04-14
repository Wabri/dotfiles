#!/usr/bin/env bash

# Post-installation tasks

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

set_zsh_as_default() {
    if ! command -v zsh &> /dev/null; then
        log_warning "Zsh is not installed, skipping shell change"
        return 1
    fi

    local current_shell=$(basename "$SHELL")

    if [[ "$current_shell" == "zsh" ]]; then
        log_success "Zsh is already the default shell"
        return 0
    fi

    log_info "Setting zsh as default shell..."

    local zsh_path=$(which zsh)

    # Check if zsh is in /etc/shells
    if ! grep -q "^$zsh_path$" /etc/shells; then
        log_warning "Adding $zsh_path to /etc/shells"
        echo "$zsh_path" | sudo tee -a /etc/shells > /dev/null
    fi

    # Change shell
    if chsh -s "$zsh_path"; then
        log_success "Default shell set to zsh (restart your terminal to apply)"
    else
        log_error "Failed to change default shell"
        return 1
    fi
}

setup_nvim() {
    if ! command -v nvim &> /dev/null; then
        log_warning "Neovim is not installed, skipping nvim setup"
        return 1
    fi

    log_info "Setting up Neovim..."

    # Check if using lazy.nvim or packer
    local nvim_config="$HOME/.config/nvim/init.lua"

    if [[ -f "$nvim_config" ]]; then
        log_info "Run ':Lazy sync' or ':PackerSync' in Neovim to install plugins"
        log_success "Neovim config is ready"
    else
        log_warning "Neovim config not found at $nvim_config"
    fi
}

setup_tmux() {
    if ! command -v tmux &> /dev/null; then
        log_warning "Tmux is not installed, skipping tmux setup"
        return 1
    fi

    log_info "Setting up Tmux..."

    # Check for TPM (Tmux Plugin Manager)
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [[ ! -d "$tpm_dir" ]]; then
        log_info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        log_success "TPM installed. Press 'prefix + I' in tmux to install plugins"
    else
        log_success "TPM is already installed"
    fi
}

enable_systemd_services() {
    log_info "Checking for systemd user services..."

    local systemd_user_dir="$HOME/.config/systemd/user"

    if [[ ! -d "$systemd_user_dir" ]]; then
        log_warning "No systemd user services found"
        return 0
    fi

    local services=($(find "$systemd_user_dir" -name "*.service" -type f -exec basename {} \;))

    if [[ ${#services[@]} -eq 0 ]]; then
        log_warning "No systemd user services found"
        return 0
    fi

    log_info "Found ${#services[@]} systemd user service(s)"

    for service in "${services[@]}"; do
        log_info "Enable $service? [y/N]"
        read -p "" -n 1 -r
        echo ""

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            systemctl --user enable "$service"
            log_success "Enabled: $service"
        fi
    done
}

install_fonts() {
    log_info "Updating font cache..."

    if command -v fc-cache &> /dev/null; then
        fc-cache -fv > /dev/null 2>&1
        log_success "Font cache updated"
    else
        log_warning "fc-cache not found, skipping font cache update"
    fi
}

setup_asdf() {
    if [[ ! -d "$HOME/.asdf" ]]; then
        log_info "ASDF version manager not found. Install it? [y/N]"
        read -p "" -n 1 -r
        echo ""

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log_info "Installing ASDF..."
            git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.14.1
            log_success "ASDF installed. Restart your shell to use it"
        fi
    else
        log_success "ASDF is already installed"
    fi
}

main() {
    echo ""
    log_info "Running post-installation tasks..."
    echo ""

    set_zsh_as_default
    echo ""

    setup_nvim
    echo ""

    setup_tmux
    echo ""

    enable_systemd_services
    echo ""

    install_fonts
    echo ""

    setup_asdf
    echo ""

    log_success "Post-installation tasks completed!"
    echo ""
    log_warning "Note: You may need to log out and back in for all changes to take effect"
}

main "$@"
