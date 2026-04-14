#!/usr/bin/env bash

# Install required packages for dotfiles

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
CORE_PACKAGES_FILE="$DOTFILES_DIR/packages.txt"

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

read_packages_from_file() {
    local file="$1"
    local packages=()

    if [[ ! -f "$file" ]]; then
        return
    fi

    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^#.*$ ]] && continue
        [[ -z "$line" ]] && continue

        packages+=("$line")
    done < "$file"

    echo "${packages[@]}"
}

get_all_config_dirs() {
    local dirs=()

    for dir in "$DOTFILES_DIR"/*; do
        if [[ -d "$dir" ]] && [[ -f "$dir/packages.txt" ]]; then
            local dirname="$(basename "$dir")"
            # Exclude special directories
            if [[ "$dirname" != "install" ]] && [[ "$dirname" != "scripts" ]] && [[ ! "$dirname" =~ ^\. ]]; then
                dirs+=("$dirname")
            fi
        fi
    done

    echo "${packages[@]}"
}

show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [DIRECTORIES...]

Install packages from packages.txt files.

OPTIONS:
    -h, --help      Show this help message
    -a, --all       Install core packages + all directory-specific packages
    -c, --core-only Install only core packages (default if no directories specified)

EXAMPLES:
    $(basename "$0")              # Install only core packages
    $(basename "$0") nvim zsh     # Install core + nvim + zsh packages
    $(basename "$0") --all        # Install core + all directory packages

PACKAGE FILES:
    Core packages:  packages.txt (always installed)
    Per-directory:  <dir>/packages.txt (optional, install with directory name)

EOF
}

main() {
    check_root

    local install_all=false
    local selected_dirs=()
    local all_packages=()

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -a|--all)
                install_all=true
                shift
                ;;
            -c|--core-only)
                # Just core packages (default behavior)
                shift
                ;;
            -*)
                log_error "Unknown option: $1"
                show_help
                exit 1
                ;;
            *)
                selected_dirs+=("$1")
                shift
                ;;
        esac
    done

    log_info "Detecting package manager..."
    local pkg_manager=$(detect_package_manager)

    if [[ "$pkg_manager" == "unknown" ]]; then
        log_error "Could not detect package manager"
        exit 1
    fi

    log_success "Detected package manager: $pkg_manager"

    # Read core packages
    log_info "Reading core packages from $CORE_PACKAGES_FILE..."
    local core_packages=($(read_packages_from_file "$CORE_PACKAGES_FILE"))

    if [[ ${#core_packages[@]} -eq 0 ]]; then
        log_warning "No core packages found in $CORE_PACKAGES_FILE"
    else
        log_info "Found ${#core_packages[@]} core packages"
        all_packages+=("${core_packages[@]}")
    fi

    # Read directory-specific packages
    if [[ "$install_all" == true ]]; then
        log_info "Reading packages from all directories..."
        for dir in "$DOTFILES_DIR"/*; do
            if [[ -d "$dir" ]] && [[ -f "$dir/packages.txt" ]]; then
                local dirname="$(basename "$dir")"
                # Exclude special directories
                if [[ "$dirname" != "install" ]] && [[ "$dirname" != "scripts" ]] && [[ ! "$dirname" =~ ^\. ]]; then
                    local dir_packages=($(read_packages_from_file "$dir/packages.txt"))
                    if [[ ${#dir_packages[@]} -gt 0 ]]; then
                        log_info "  → $dirname: ${#dir_packages[@]} packages"
                        all_packages+=("${dir_packages[@]}")
                    fi
                fi
            fi
        done
    elif [[ ${#selected_dirs[@]} -gt 0 ]]; then
        log_info "Reading packages from selected directories..."
        for dirname in "${selected_dirs[@]}"; do
            local dir="$DOTFILES_DIR/$dirname"
            if [[ ! -d "$dir" ]]; then
                log_error "Directory not found: $dirname"
                exit 1
            fi

            if [[ -f "$dir/packages.txt" ]]; then
                local dir_packages=($(read_packages_from_file "$dir/packages.txt"))
                if [[ ${#dir_packages[@]} -gt 0 ]]; then
                    log_info "  → $dirname: ${#dir_packages[@]} packages"
                    all_packages+=("${dir_packages[@]}")
                else
                    log_warning "  → $dirname: no packages found"
                fi
            else
                log_warning "  → $dirname: no packages.txt file"
            fi
        done
    fi

    # Deduplicate packages (preserving order)
    local unique_packages=()
    local seen_packages=()

    for pkg in "${all_packages[@]}"; do
        if [[ ! " ${seen_packages[@]} " =~ " ${pkg} " ]]; then
            unique_packages+=("$pkg")
            seen_packages+=("$pkg")
        fi
    done

    if [[ ${#unique_packages[@]} -eq 0 ]]; then
        log_warning "No packages to install"
        exit 0
    fi

    echo ""
    log_info "Total: ${#unique_packages[@]} unique packages to install"
    echo ""

    # Ask for confirmation
    log_warning "The following packages will be installed:"
    if command -v column &> /dev/null; then
        printf '%s\n' "${unique_packages[@]}" | column
    else
        printf '  - %s\n' "${unique_packages[@]}"
    fi
    echo ""

    read -p "Do you want to continue? [y/N] " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Installation cancelled"
        exit 0
    fi

    # Install packages
    if install_packages "$pkg_manager" "${unique_packages[@]}"; then
        log_success "All packages installed successfully"
    else
        log_error "Some packages failed to install"
        exit 1
    fi
}

main "$@"
