#!/bin/bash

# Static Hands - Basic Edition Installer
# Platform: macOS (Karabiner-Elements)

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CONFIG_NAME="static-hands-basic-macos.json"
CONFIG_DIR="$HOME/.config/karabiner/assets/complex_modifications"
KARABINER_JSON="$HOME/.config/karabiner/karabiner.json"
BACKUP_DIR="$HOME/.config/karabiner/backups"

# Helper functions
print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if Karabiner-Elements is installed
check_karabiner() {
    if [ -d "/Applications/Karabiner-Elements.app" ]; then
        return 0
    else
        return 1
    fi
}

# Create backup of existing configuration
backup_config() {
    if [ -f "$CONFIG_DIR/$CONFIG_NAME" ]; then
        mkdir -p "$BACKUP_DIR"
        TIMESTAMP=$(date +%Y%m%d_%H%M%S)
        BACKUP_FILE="$BACKUP_DIR/${CONFIG_NAME%.json}_${TIMESTAMP}.json"
        cp "$CONFIG_DIR/$CONFIG_NAME" "$BACKUP_FILE"
        print_success "Backed up existing configuration to: $BACKUP_FILE"
        return 0
    else
        return 1
    fi
}

# Install Karabiner-Elements
install_karabiner() {
    print_header "Installing Karabiner-Elements"

    if command -v brew &> /dev/null; then
        print_info "Installing via Homebrew..."
        brew install --cask karabiner-elements
        print_success "Karabiner-Elements installed successfully"
    else
        print_warning "Homebrew not found. Please install manually:"
        echo ""
        echo "1. Visit: https://karabiner-elements.pqrs.org/"
        echo "2. Download and install the .dmg file"
        echo "3. Run this installer again"
        echo ""
        exit 1
    fi
}

# Install configuration
install_config() {
    print_header "Installing Static Hands Basic Configuration"

    # Create config directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"

    # Check if config file exists in current directory
    if [ -f "./$CONFIG_NAME" ]; then
        cp "./$CONFIG_NAME" "$CONFIG_DIR/"
        print_success "Configuration file installed"
    else
        print_error "Configuration file not found in current directory"
        echo "Please make sure $CONFIG_NAME is in the same directory as this installer"
        exit 1
    fi

    # Verify JSON validity (if Python is available)
    if command -v python3 &> /dev/null; then
        if python3 -m json.tool "$CONFIG_DIR/$CONFIG_NAME" > /dev/null 2>&1; then
            print_success "Configuration file is valid JSON"
        else
            print_error "Configuration file has invalid JSON syntax"
            exit 1
        fi
    fi
}

# Restart Karabiner
restart_karabiner() {
    print_info "Restarting Karabiner-Elements..."
    killall "Karabiner-Elements" 2>/dev/null || true
    sleep 2
    open -a "Karabiner-Elements"
    sleep 2
    print_success "Karabiner-Elements restarted"
}

# Show post-installation instructions
show_instructions() {
    print_header "Installation Complete! 🎉"
    
    echo "Configuration file installed successfully!"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "IMPORTANT: Complete these steps to activate Static Hands:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "1. Grant Permissions:"
    echo "   • System Settings → Privacy & Security → Input Monitoring"
    echo "   • Enable 'karabiner_grabber' and 'karabiner_observer'"
    echo ""
    echo "2. Enable the Rule in Karabiner-Elements:"
    echo "   • Open Karabiner-Elements (should be open now)"
    echo "   • Go to 'Complex Modifications' tab"
    echo "   • Click 'Add rule' button"
    echo "   • Find 'Static Hands - Basic (macOS)'"
    echo "   • Click 'Enable' button"
    echo ""
    echo "3. Test the configuration:"
    echo "   • Open any text editor"
    echo "   • Try: CapsLock + I/K/J/L (arrow keys)"
    echo "   • Try: CapsLock + U/O (line start/end)"
    echo "   • Try: CapsLock + Y/N (page up/down)"
    echo ""
    echo "💡 Want more features?"
    echo "   • Check out the Advanced edition in ../Advanced/"
    echo "   • Includes text editing, modifiers, case transform, and more!"
    echo ""
    print_success "Setup complete! Enable the rule in Karabiner to start using Static Hands. ⌨️✨"
}

# Main installation flow
main() {
    clear
    print_header "Static Hands - Basic Edition Installer"
    echo "Platform: macOS (Karabiner-Elements)"
    echo ""

    # Check for existing installation
    if [ -f "$CONFIG_DIR/$CONFIG_NAME" ]; then
        print_warning "Existing Static Hands Basic configuration detected"
        echo ""
        read -p "Do you want to upgrade? (y/n): " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            backup_config
            print_info "Proceeding with upgrade..."
        else
            print_info "Installation cancelled"
            exit 0
        fi
    fi

    # Check Karabiner-Elements
    if ! check_karabiner; then
        print_warning "Karabiner-Elements is not installed"
        echo ""
        read -p "Do you want to install it now? (y/n): " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_karabiner
        else
            print_error "Karabiner-Elements is required. Please install it first."
            exit 1
        fi
    else
        print_success "Karabiner-Elements is installed"
    fi

    # Install configuration
    install_config

    # Restart Karabiner
    restart_karabiner

    # Show instructions
    show_instructions
}

# Run main function
main