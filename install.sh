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

Automated dotfiles installation.

OPTIONS:
    -h, --help             Show this help message
    -s, --skip-backup      Skip backup of existing dotfiles
    -y, --yes              Automatic yes to prompts
    --rollback <dir>       Restore dotfiles from backup directory

EXAMPLES:
    $(basename "$0")                                    # Interactive installation
    $(basename "$0") --rollback ~/.dotfiles_backup_*    # Restore from backup

RECOMMENDED WORKFLOW:
    $(basename "$0")                      # Install dotfiles (stow configs)
    dotfiles packages nvim zsh            # Install packages for specific tools
    dotfiles post-install                 # Run post-installation tasks

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

    # Confirm installation
    read -p "Proceed with installation? [Y/n] " -n 1 -r
    echo ""
    echo ""

    if [[ $REPLY =~ ^[Nn]$ ]]; then
        log_info "Installation cancelled"
        exit 0
    fi
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

rollback_dotfiles() {
    local backup_dir="$1"

    log_header "Rolling back dotfiles"

    # Validate backup directory
    if [[ -z "$backup_dir" ]]; then
        log_error "No backup directory specified"
        log_info "Usage: $(basename "$0") --rollback <backup-directory>"
        log_info "Available backups:"
        ls -dt ~/.dotfiles_backup_* 2>/dev/null | head -5 || log_info "  No backups found"
        exit 1
    fi

    if [[ ! -d "$backup_dir" ]]; then
        log_error "Backup directory not found: $backup_dir"
        log_info "Available backups:"
        ls -dt ~/.dotfiles_backup_* 2>/dev/null | head -5 || log_info "  No backups found"
        exit 1
    fi

    # Show backup info
    log_info "Backup directory: $backup_dir"
    log_info "Created: $(stat -c %y "$backup_dir" 2>/dev/null | cut -d. -f1 || date -r "$backup_dir" "+%Y-%m-%d %H:%M:%S" 2>/dev/null)"
    echo ""
    log_info "Files in backup:"
    find "$backup_dir" -type f | sed "s|$backup_dir/|  |" | head -20
    echo ""

    # Confirm rollback
    log_warning "This will:"
    echo "  1. Unstow all current dotfiles"
    echo "  2. Restore files from backup: $backup_dir"
    echo "  3. This will overwrite current dotfiles!"
    echo ""
    read -p "Are you sure you want to rollback? [y/N] " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Rollback cancelled"
        exit 0
    fi

    # Unstow all packages
    log_info "Unstowing all current dotfiles..."
    if [[ -f "$SCRIPT_DIR/install/stow.sh" ]]; then
        bash "$SCRIPT_DIR/install/stow.sh" --unstow 2>/dev/null || log_warning "Some packages were not stowed"
        log_success "Unstowed current dotfiles"
    else
        log_warning "Stow script not found, skipping unstow"
    fi

    # Restore from backup
    log_info "Restoring files from backup..."
    local restored=0
    local failed=0

    while IFS= read -r -d '' file; do
        local rel_path="${file#$backup_dir/}"
        local target="$HOME/$rel_path"
        local target_dir="$(dirname "$target")"

        # Create directory if needed
        if [[ ! -d "$target_dir" ]]; then
            mkdir -p "$target_dir"
        fi

        # Copy file
        if cp -p "$file" "$target"; then
            ((restored++))
        else
            log_error "Failed to restore: $rel_path"
            ((failed++))
        fi
    done < <(find "$backup_dir" -type f -print0)

    echo ""
    log_success "Restored $restored file(s)"
    if [[ $failed -gt 0 ]]; then
        log_warning "Failed to restore $failed file(s)"
    fi

    # Done
    log_header "Rollback complete!"
    log_success "Your dotfiles have been restored from backup"
    echo ""
    log_info "Backup kept at: $backup_dir"
    log_warning "Remember to restart your shell/WM for changes to take effect"
    echo ""
}

main() {
    # Default options
    SKIP_BACKUP=false
    INTERACTIVE=true

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -s|--skip-backup)
                SKIP_BACKUP=true
                shift
                ;;
            -y|--yes)
                AUTO_YES=true
                shift
                ;;
            --rollback)
                if [[ -z "$2" ]]; then
                    log_error "--rollback requires a backup directory"
                    exit 1
                fi
                rollback_dotfiles "$2"
                exit 0
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
    if [[ "$SKIP_BACKUP" == false ]]; then
        run_backup
    fi

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
