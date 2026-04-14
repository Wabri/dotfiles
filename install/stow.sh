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
CYAN='\033[0;36m'
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

    # First show what stow would do (capture both stdout and stderr, allow errors)
    local stow_output=$(stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" -n -v "$package" 2>&1) || true

    if [[ -z "$stow_output" ]]; then
        log_info "  No changes (already stowed)"
        echo ""
        return 0
    fi

    # Parse stow output to find files that would be linked
    local files_to_link=()
    while IFS= read -r line; do
        if [[ "$line" =~ LINK:\ (.*)\ =\>\ (.*) ]]; then
            local link_path="${BASH_REMATCH[1]}"
            files_to_link+=("$link_path")
        fi
    done <<< "$stow_output"

    # If no LINK lines found, check for conflicts and manually find files
    if [[ ${#files_to_link[@]} -eq 0 ]]; then
        # Find all files in the package directory (exclude .stow-local-ignore and packages.txt)
        while IFS= read -r file; do
            local rel_path="${file#$DOTFILES_DIR/$package/}"
            files_to_link+=("$rel_path")
        done < <(find "$DOTFILES_DIR/$package" -type f -not -name ".stow-local-ignore" -not -name "packages.txt")
    fi

    # Show diff for each file
    for link_path in "${files_to_link[@]}"; do
        local target_file="$TARGET_DIR/$link_path"
        local source_file="$DOTFILES_DIR/$package/$link_path"

        echo -e "${CYAN}File: $link_path${NC}"

        if [[ -f "$target_file" ]] && [[ ! -L "$target_file" ]]; then
            # File exists and is not a symlink - show diff
            echo -e "${YELLOW}  → Will replace existing file with symlink${NC}"
            echo ""

            if command -v diff &> /dev/null; then
                # Show actual content diff
                echo "  Content changes:"
                diff -u "$target_file" "$source_file" 2>/dev/null | tail -n +3 | while IFS= read -r diffline; do
                    if [[ "$diffline" =~ ^\- ]]; then
                        echo -e "  ${RED}$diffline${NC}"
                    elif [[ "$diffline" =~ ^\+ ]]; then
                        echo -e "  ${GREEN}$diffline${NC}"
                    elif [[ "$diffline" =~ ^@ ]]; then
                        echo -e "  ${BLUE}$diffline${NC}"
                    else
                        echo "  $diffline"
                    fi
                done || echo -e "  ${YELLOW}(Binary file or no diff tool)${NC}"
            fi
        elif [[ -L "$target_file" ]]; then
            # Already a symlink
            local current_target=$(readlink "$target_file")
            echo -e "${BLUE}  → Already symlinked to: $current_target${NC}"
        else
            # New file
            echo -e "${GREEN}  → Will create new symlink${NC}"

            if [[ -f "$source_file" ]] && command -v wc &> /dev/null; then
                local lines=$(wc -l < "$source_file")
                echo -e "  ${BLUE}  New file: $lines lines${NC}"

                # Show first few lines
                echo "  Preview (first 10 lines):"
                head -10 "$source_file" 2>/dev/null | while IFS= read -r line; do
                    echo -e "  ${GREEN}+ $line${NC}"
                done
            fi
        fi
        echo ""
    done

    # Show stow simulation warnings
    if echo "$stow_output" | grep -q "WARNING\|ERROR"; then
        echo -e "${YELLOW}Stow warnings:${NC}"
        echo "$stow_output" | grep "WARNING\|ERROR" | while IFS= read -r line; do
            echo "  $line"
        done
        echo ""
    fi
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
