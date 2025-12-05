#!/usr/bin/env bash

# Wabri's Dotfiles Installation Script
# Automated installation for openSUSE Tumbleweed

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
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

log_header() {
    echo ""
    echo -e "${CYAN}${BOLD}▸ $1${NC}"
    echo ""
}

show_banner() {
    cat << "EOF"
╔══════════════════════════════════════════════════════╗
║                                                      ║
║        Wabri's Dotfiles Installation Script         ║
║                                                      ║
╚══════════════════════════════════════════════════════╝
EOF
    echo ""
}

show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Automated dotfiles installation for openSUSE Tumbleweed and other distros.

OPTIONS:
    -h, --help          Show this help message
    -f, --full          Full installation (packages + dotfiles + post-install)
    -d, --dotfiles-only Install dotfiles only (skip packages and post-install)
    -p, --packages-only Install packages only (skip dotfiles)
    -s, --skip-backup   Skip backup of existing dotfiles
    -y, --yes           Automatic yes to prompts

EXAMPLES:
    $(basename "$0")                  # Interactive installation
    $(basename "$0") --full           # Full automated installation
    $(basename "$0") --dotfiles-only  # Only stow dotfiles
    $(basename "$0") --packages-only  # Only install packages

EOF
}

check_dependencies() {
    log_info "Checking dependencies..."

    local missing_deps=()

    if ! command -v git &> /dev/null; then
        missing_deps+=("git")
    fi

    if ! command -v stow &> /dev/null; then
        missing_deps+=("stow")
    fi

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_error "Missing required dependencies: ${missing_deps[*]}"
        log_info "Please install them first and run this script again"
        exit 1
    fi

    log_success "All required dependencies found"
}

run_backup() {
    log_header "Backing up existing dotfiles"

    if [[ -f "$SCRIPT_DIR/install/backup.sh" ]]; then
        bash "$SCRIPT_DIR/install/backup.sh"
    else
        log_error "Backup script not found"
        exit 1
    fi
}

run_packages() {
    log_header "Installing packages"

    if [[ -f "$SCRIPT_DIR/install/packages.sh" ]]; then
        bash "$SCRIPT_DIR/install/packages.sh"
    else
        log_error "Packages script not found"
        exit 1
    fi
}

run_stow() {
    log_header "Stowing dotfiles"

    if [[ -f "$SCRIPT_DIR/install/stow.sh" ]]; then
        bash "$SCRIPT_DIR/install/stow.sh"
    else
        log_error "Stow script not found"
        exit 1
    fi
}

run_post_install() {
    log_header "Running post-installation tasks"

    if [[ -f "$SCRIPT_DIR/install/post-install.sh" ]]; then
        bash "$SCRIPT_DIR/install/post-install.sh"
    else
        log_error "Post-install script not found"
        exit 1
    fi
}

interactive_install() {
    show_banner

    log_info "This script will help you install Wabri's dotfiles"
    log_warning "Make sure you have reviewed the configuration before proceeding"
    echo ""

    # Ask what to install
    log_info "What would you like to install?"
    echo ""
    echo "  1) Full installation (recommended)"
    echo "  2) Dotfiles only"
    echo "  3) Packages only"
    echo "  4) Custom (choose components)"
    echo ""

    read -p "Enter your choice [1-4]: " choice

    case "$choice" in
        1)
            INSTALL_PACKAGES=true
            INSTALL_DOTFILES=true
            INSTALL_POST=true
            ;;
        2)
            INSTALL_PACKAGES=false
            INSTALL_DOTFILES=true
            INSTALL_POST=false
            ;;
        3)
            INSTALL_PACKAGES=true
            INSTALL_DOTFILES=false
            INSTALL_POST=false
            ;;
        4)
            echo ""
            read -p "Install packages? [Y/n] " -n 1 -r
            echo ""
            [[ $REPLY =~ ^[Nn]$ ]] && INSTALL_PACKAGES=false || INSTALL_PACKAGES=true

            read -p "Install dotfiles? [Y/n] " -n 1 -r
            echo ""
            [[ $REPLY =~ ^[Nn]$ ]] && INSTALL_DOTFILES=false || INSTALL_DOTFILES=true

            read -p "Run post-install tasks? [Y/n] " -n 1 -r
            echo ""
            [[ $REPLY =~ ^[Nn]$ ]] && INSTALL_POST=false || INSTALL_POST=true
            ;;
        *)
            log_error "Invalid choice"
            exit 1
            ;;
    esac

    echo ""
    read -p "Create backup of existing dotfiles? [Y/n] " -n 1 -r
    echo ""
    [[ $REPLY =~ ^[Nn]$ ]] && SKIP_BACKUP=true || SKIP_BACKUP=false

    echo ""
    log_warning "Ready to proceed with installation"
    read -p "Continue? [y/N] " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Installation cancelled"
        exit 0
    fi
}

main() {
    # Default options
    INSTALL_PACKAGES=false
    INSTALL_DOTFILES=false
    INSTALL_POST=false
    SKIP_BACKUP=false
    INTERACTIVE=true

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -f|--full)
                INSTALL_PACKAGES=true
                INSTALL_DOTFILES=true
                INSTALL_POST=true
                INTERACTIVE=false
                shift
                ;;
            -d|--dotfiles-only)
                INSTALL_DOTFILES=true
                INTERACTIVE=false
                shift
                ;;
            -p|--packages-only)
                INSTALL_PACKAGES=true
                INTERACTIVE=false
                shift
                ;;
            -s|--skip-backup)
                SKIP_BACKUP=true
                shift
                ;;
            -y|--yes)
                AUTO_YES=true
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done

    # Run interactive mode if no options specified
    if [[ "$INTERACTIVE" == true ]]; then
        interactive_install
    fi

    # Start installation
    log_header "Starting installation"

    check_dependencies

    # Backup
    if [[ "$SKIP_BACKUP" == false ]] && [[ "$INSTALL_DOTFILES" == true ]]; then
        run_backup
    fi

    # Install packages
    if [[ "$INSTALL_PACKAGES" == true ]]; then
        run_packages
    fi

    # Stow dotfiles
    if [[ "$INSTALL_DOTFILES" == true ]]; then
        run_stow
    fi

    # Post-install
    if [[ "$INSTALL_POST" == true ]]; then
        run_post_install
    fi

    # Done
    log_header "Installation complete!"

    log_success "Your dotfiles have been installed successfully!"
    echo ""
    log_info "Next steps:"
    echo "  • Log out and back in for shell changes to take effect"
    echo "  • Open Neovim and run :Lazy sync (or :PackerSync) to install plugins"
    echo "  • Open Tmux and press prefix + I to install plugins"
    echo "  • Restart your window manager/compositor if you installed WM configs"
    echo ""

    log_info "Enjoy your new setup! 🚀"
    echo ""
}

main "$@"
