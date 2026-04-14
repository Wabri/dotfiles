#!/usr/bin/env bash

# Stow dotfiles to home directory

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
TARGET_DIR="$HOME"

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

check_stow() {
    if ! command -v stow &> /dev/null; then
        log_error "GNU Stow is not installed. Please install it first."
        exit 1
    fi
}

get_stow_packages() {
    local packages=()

    # Get all directories that contain dotfiles (exclude hidden dirs, scripts, and install)
    for dir in "$DOTFILES_DIR"/*; do
        local dirname="$(basename "$dir")"
        if [[ -d "$dir" ]] && [[ ! "$dirname" =~ ^\. ]] && [[ "$dirname" != "scripts" ]] && [[ "$dirname" != "install" ]]; then
            packages+=("$dirname")
        fi
    done

    echo "${packages[@]}"
}

stow_package() {
    local package="$1"

    log_info "Stowing: $package"

    if stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" -v "$package" 2>&1 | grep -q "LINK"; then
        log_success "Stowed: $package"
        return 0
    else
        log_warning "Already stowed or no changes: $package"
        return 0
    fi
}

unstow_package() {
    local package="$1"

    log_info "Unstowing: $package"

    if stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" -D -v "$package" 2>&1; then
        log_success "Unstowed: $package"
        return 0
    else
        log_error "Failed to unstow: $package"
        return 1
    fi
}

restow_package() {
    local package="$1"

    log_info "Restowing: $package"

    if stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" -R -v "$package" 2>&1; then
        log_success "Restowed: $package"
        return 0
    else
        log_error "Failed to restow: $package"
        return 1
    fi
}

preview_package() {
    local package="$1"

    log_info "Preview: $package"
    echo ""

    # Run stow in dry-run mode (-n) with verbose output
    local output=$(stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" -n -v "$package" 2>&1)

    if [[ -z "$output" ]]; then
        log_info "  No changes (already stowed or no conflicts)"
    else
        echo "$output" | while IFS= read -r line; do
            if [[ "$line" =~ LINK:.*-\> ]]; then
                echo -e "  ${GREEN}+${NC} $line"
            elif [[ "$line" =~ WARNING ]]; then
                echo -e "  ${YELLOW}!${NC} $line"
            elif [[ "$line" =~ ERROR ]]; then
                echo -e "  ${RED}✗${NC} $line"
            else
                echo "  $line"
            fi
        done
    fi
    echo ""
}

show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS] [PACKAGES...]

Stow dotfiles to home directory using GNU Stow.

OPTIONS:
    -h, --help      Show this help message
    -u, --unstow    Unstow (remove symlinks) instead of stow
    -r, --restow    Restow (remove and recreate symlinks)
    -l, --list      List available packages
    -n, --preview   Preview changes without applying (dry run)

EXAMPLES:
    $(basename "$0")              # Stow all packages
    $(basename "$0") nvim zsh     # Stow only nvim and zsh
    $(basename "$0") -u sway      # Unstow sway
    $(basename "$0") -r nvim      # Restow nvim
    $(basename "$0") -n nvim      # Preview nvim changes (dry run)

EOF
}

list_packages() {
    local packages=($(get_stow_packages))

    echo "Available packages:"
    printf '  - %s\n' "${packages[@]}"
}

main() {
    check_stow

    local action="stow"
    local selected_packages=()

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -u|--unstow)
                action="unstow"
                shift
                ;;
            -r|--restow)
                action="restow"
                shift
                ;;
            -l|--list)
                list_packages
                exit 0
                ;;
            -n|--preview)
                action="preview"
                shift
                ;;
            *)
                selected_packages+=("$1")
                shift
                ;;
        esac
    done

    # If no packages specified, use all
    if [[ ${#selected_packages[@]} -eq 0 ]]; then
        selected_packages=($(get_stow_packages))
    fi

    log_info "Action: $action"
    log_info "Target: $TARGET_DIR"
    log_info "Packages: ${selected_packages[*]}"
    echo ""

    local failed=0

    for package in "${selected_packages[@]}"; do
        if [[ ! -d "$DOTFILES_DIR/$package" ]]; then
            log_error "Package not found: $package"
            ((failed++))
            continue
        fi

        case "$action" in
            stow)
                stow_package "$package" || ((failed++))
                ;;
            unstow)
                unstow_package "$package" || ((failed++))
                ;;
            restow)
                restow_package "$package" || ((failed++))
                ;;
            preview)
                preview_package "$package"
                ;;
        esac
    done

    echo ""

    if [[ $failed -eq 0 ]]; then
        log_success "All operations completed successfully"
    else
        log_error "$failed operation(s) failed"
        exit 1
    fi
}

main "$@"
