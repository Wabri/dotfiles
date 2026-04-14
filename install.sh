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

Automated dotfiles installation (stows configs).

OPTIONS:
    -h, --help             Show this help message
    -y, --yes              Automatic yes to prompts

EXAMPLES:
    $(basename "$0")                      # Interactive installation

RECOMMENDED WORKFLOW:
    $(basename "$0")                      # Install dotfiles (stow configs)
    dotfiles packages nvim zsh            # Install packages for specific tools
    dotfiles setup                        # Run setup tasks

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

    # Confirm installation
    read -p "Proceed with installation? [Y/n] " -n 1 -r
    echo ""
    echo ""

    if [[ $REPLY =~ ^[Nn]$ ]]; then
        log_info "Installation cancelled"
        exit 0
    fi
}

main() {
    # Default options
    INTERACTIVE=true

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
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

    # Stow dotfiles
    run_stow

    # Done
    log_header "Installation complete!"

    log_success "Your dotfiles have been stowed successfully!"
    echo ""
    log_info "Next steps:"
    echo "  1. Install packages for the configs you want:"
    echo "     ${BLUE}dotfiles packages nvim zsh${NC}"
    echo ""
    echo "  2. Run setup tasks:"
    echo "     ${BLUE}dotfiles setup${NC}"
    echo ""
    echo "  3. Log out and back in for shell changes to take effect"
    echo ""
    echo "  4. Open Neovim and run :Lazy sync to install plugins"
    echo ""

    log_info "Enjoy your new setup! 🚀"
    echo ""
}

main "$@"
