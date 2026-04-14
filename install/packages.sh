#!/usr/bin/env bash

# Install required packages for dotfiles

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
PACKAGES_FILE="$DOTFILES_DIR/packages.txt"

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

check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "This script should not be run as root (don't use sudo)"
        exit 1
    fi
}

detect_package_manager() {
    if command -v zypper &> /dev/null; then
        echo "zypper"
    elif command -v apt &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    else
        echo "unknown"
    fi
}

install_packages() {
    local pkg_manager="$1"
    shift
    local packages=("$@")

    case "$pkg_manager" in
        zypper)
            log_info "Installing packages with zypper..."
            sudo zypper install -y "${packages[@]}"
            ;;
        apt)
            log_info "Installing packages with apt..."
            sudo apt update
            sudo apt install -y "${packages[@]}"
            ;;
        dnf)
            log_info "Installing packages with dnf..."
            sudo dnf install -y "${packages[@]}"
            ;;
        pacman)
            log_info "Installing packages with pacman..."
            sudo pacman -S --noconfirm "${packages[@]}"
            ;;
        *)
            log_error "Unknown package manager. Please install packages manually."
            return 1
            ;;
    esac
}

read_packages() {
    local packages=()

    if [[ ! -f "$PACKAGES_FILE" ]]; then
        log_error "Packages file not found: $PACKAGES_FILE"
        return 1
    fi

    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^#.*$ ]] && continue
        [[ -z "$line" ]] && continue

        packages+=("$line")
    done < "$PACKAGES_FILE"

    echo "${packages[@]}"
}

main() {
    check_root

    log_info "Detecting package manager..."
    local pkg_manager=$(detect_package_manager)

    if [[ "$pkg_manager" == "unknown" ]]; then
        log_error "Could not detect package manager"
        exit 1
    fi

    log_success "Detected package manager: $pkg_manager"

    log_info "Reading packages from $PACKAGES_FILE..."
    local packages=($(read_packages))

    if [[ ${#packages[@]} -eq 0 ]]; then
        log_warning "No packages to install"
        exit 0
    fi

    log_info "Found ${#packages[@]} packages to install"

    # Ask for confirmation
    echo ""
    log_warning "The following packages will be installed:"
    if command -v column &> /dev/null; then
        printf '%s\n' "${packages[@]}" | column
    else
        printf '  - %s\n' "${packages[@]}"
    fi
    echo ""

    read -p "Do you want to continue? [y/N] " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Installation cancelled"
        exit 0
    fi

    # Install packages
    if install_packages "$pkg_manager" "${packages[@]}"; then
        log_success "All packages installed successfully"
    else
        log_error "Some packages failed to install"
        exit 1
    fi
}

main "$@"
