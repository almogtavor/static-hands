#!/bin/bash
#
# Static Hands installer for macOS (Karabiner-Elements)
#
# Runs without prompts. Install with:
#   curl -fsSL https://raw.githubusercontent.com/almogtavor/static-hands/main/mac/install.sh | bash
#
# What it does:
#   1. Installs Karabiner-Elements if it is missing
#   2. Copies the Static Hands rules into Karabiner's config folder
#   3. Enables the rules in the active Karabiner profile
#   4. Opens Karabiner-Elements so macOS can ask for the permissions it needs
#
# Options:
#   --config-only   skip steps 1 and 4 (only install and enable the rules)

set -euo pipefail

CONFIG_NAME="static-hands-basic-macos.json"
CONFIG_URL="https://raw.githubusercontent.com/almogtavor/static-hands/main/mac/$CONFIG_NAME"
KARABINER_APP="/Applications/Karabiner-Elements.app"
KARABINER_DIR="$HOME/.config/karabiner"
ASSETS_DIR="$KARABINER_DIR/assets/complex_modifications"
KARABINER_JSON="$KARABINER_DIR/karabiner.json"
BACKUP_DIR="$KARABINER_DIR/backups"

CONFIG_ONLY=0
[ "${1:-}" = "--config-only" ] && CONFIG_ONLY=1

if [ -t 1 ]; then
    RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; BLUE=$'\033[0;34m'; BOLD=$'\033[1m'; NC=$'\033[0m'
else
    RED=""; GREEN=""; YELLOW=""; BLUE=""; BOLD=""; NC=""
fi

step()    { echo; echo "${BLUE}${BOLD}==> $1${NC}"; }
ok()      { echo "${GREEN}✅ $1${NC}"; }
warn()    { echo "${YELLOW}⚠️  $1${NC}"; }
fail()    { echo "${RED}❌ $1${NC}" >&2; exit 1; }

WORK_DIR="$(mktemp -d)"
MOUNT_POINT=""
cleanup() {
    [ -n "$MOUNT_POINT" ] && hdiutil detach "$MOUNT_POINT" -quiet 2>/dev/null || true
    rm -rf "$WORK_DIR"
}
trap cleanup EXIT

# Directory of this script, when it is run from a file (empty for `curl | bash`).
SCRIPT_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

# ---------------------------------------------------------------------------
# 1. Karabiner-Elements
# ---------------------------------------------------------------------------
install_karabiner() {
    step "Installing Karabiner-Elements"

    if command -v brew >/dev/null 2>&1; then
        echo "Installing with Homebrew (macOS will ask for your password)..."
        if brew install --cask karabiner-elements; then
            return 0
        fi
        warn "Homebrew install failed, falling back to the official installer"
    fi

    echo "Downloading the official installer from GitHub..."
    local url
    url="$(curl -fsSL https://api.github.com/repos/pqrs-org/Karabiner-Elements/releases/latest \
        | grep -o '"browser_download_url": *"[^"]*\.dmg"' | head -1 | sed 's/.*"\(https[^"]*\)"/\1/')" || true
    if [ -z "$url" ]; then
        open "https://karabiner-elements.pqrs.org/"
        fail "Could not find the Karabiner-Elements download. Install it from the page that just opened, then run this installer again."
    fi

    curl -fL --progress-bar -o "$WORK_DIR/karabiner.dmg" "$url"
    MOUNT_POINT="$WORK_DIR/karabiner-mount"
    mkdir -p "$MOUNT_POINT"
    hdiutil attach "$WORK_DIR/karabiner.dmg" -nobrowse -quiet -mountpoint "$MOUNT_POINT"

    local pkg
    pkg="$(find "$MOUNT_POINT" -maxdepth 1 -name '*.pkg' | head -1)"
    [ -n "$pkg" ] || fail "The Karabiner-Elements download did not contain an installer."

    echo
    echo "${BOLD}The Karabiner-Elements installer is opening.${NC}"
    echo "Click Continue → Install, enter your password, and come back here when it finishes."
    open -W "$pkg"
}

# ---------------------------------------------------------------------------
# 2. Rules file
# ---------------------------------------------------------------------------
install_rules() {
    step "Installing the Static Hands rules"
    mkdir -p "$ASSETS_DIR"

    local source=""
    if [ -n "$SCRIPT_DIR" ]; then
        for candidate in "$SCRIPT_DIR/$CONFIG_NAME" "$SCRIPT_DIR/.$CONFIG_NAME"; do
            [ -f "$candidate" ] && source="$candidate" && break
        done
    fi

    if [ -n "$source" ]; then
        cp "$source" "$WORK_DIR/$CONFIG_NAME"
    else
        curl -fsSL -o "$WORK_DIR/$CONFIG_NAME" "$CONFIG_URL" \
            || fail "Could not download $CONFIG_NAME. Check your internet connection and try again."
    fi

    cp "$WORK_DIR/$CONFIG_NAME" "$ASSETS_DIR/$CONFIG_NAME"
    ok "Rules copied to $ASSETS_DIR"
}

# ---------------------------------------------------------------------------
# 3. Enable the rules in the active profile
# ---------------------------------------------------------------------------
# Uses JavaScript for Automation, which ships with every macOS, so no Python,
# Node or Xcode tools are needed.
enable_rules() {
    step "Enabling Static Hands in Karabiner-Elements"

    if [ -f "$KARABINER_JSON" ]; then
        mkdir -p "$BACKUP_DIR"
        local backup="$BACKUP_DIR/karabiner_before_static_hands_$(date +%Y%m%d_%H%M%S).json"
        cp "$KARABINER_JSON" "$backup"
        echo "Backed up your current Karabiner settings to $backup"
    fi

    cat > "$WORK_DIR/enable.js" <<'JXA'
ObjC.import('Foundation');

function read(path) {
    var s = $.NSString.stringWithContentsOfFileEncodingError(path, $.NSUTF8StringEncoding, null);
    return s.isNil() ? null : s.js;
}

function run(argv) {
    var configPath = argv[0];
    var rulesPath = argv[1];

    var rules = JSON.parse(read(rulesPath)).rules;
    var raw = read(configPath);
    var config = raw === null ? {} : JSON.parse(raw);

    if (!Array.isArray(config.profiles) || config.profiles.length === 0) {
        config.profiles = [{ name: 'Default profile', selected: true }];
    }
    var profile = config.profiles.filter(function (p) { return p.selected; })[0] || config.profiles[0];
    if (!profile.complex_modifications) profile.complex_modifications = {};
    var existing = profile.complex_modifications.rules || [];

    // Replace any previous copy of the Static Hands rules, keep everything else.
    var names = rules.map(function (r) { return r.description; });
    var kept = existing.filter(function (r) { return names.indexOf(r.description) === -1; });
    profile.complex_modifications.rules = rules.concat(kept);

    var out = $(JSON.stringify(config, null, 4) + '\n');
    // Not atomic on purpose: keeps a symlinked karabiner.json a symlink.
    if (!out.writeToFileAtomicallyEncodingError(configPath, false, $.NSUTF8StringEncoding, null)) {
        throw new Error('could not write ' + configPath);
    }
    return 'Enabled in profile "' + profile.name + '"';
}
JXA

    local result
    if result="$(osascript -l JavaScript "$WORK_DIR/enable.js" "$KARABINER_JSON" "$WORK_DIR/$CONFIG_NAME" 2>&1)"; then
        ok "$result"
        return 0
    fi

    warn "Could not enable the rules automatically ($result)"
    echo "Enable them by hand: Karabiner-Elements → Complex Modifications → Add predefined rule →"
    echo "\"Static Hands - Basic\" → Enable All."
    return 0
}

# ---------------------------------------------------------------------------
# 4. Hand over to Karabiner for the macOS permissions
# ---------------------------------------------------------------------------
finish() {
    if [ "$CONFIG_ONLY" -eq 0 ]; then
        open -a "Karabiner-Elements" 2>/dev/null || true
    fi

    step "Static Hands is installed 🎉"
    cat <<EOF

${BOLD}One thing left that only you can do:${NC} nothing works until you approve
Karabiner-Elements. Open ${BOLD}System Settings${NC} and turn on these three switches
(you only do this once):

  1. General → Login Items & Extensions → Allow in the Background:
     every Karabiner-Elements entry (some are listed as "Fumihiko Takayama")
  2. Same page → Extensions → Driver Extensions → (i):
     Karabiner-DriverKit-VirtualHIDDevice (asks for your password)
  3. Privacy & Security → Input Monitoring:
     Karabiner-Core-Service

If macOS also asks to allow Karabiner-Elements under Accessibility, allow it.

Then try it in any text field: hold ${BOLD}CapsLock${NC} and press ${BOLD}I / J / K / L${NC} to move the cursor.

Pictures of every step: https://almogtavor.github.io/static-hands/docs/intro
EOF
}

main() {
    echo "${BOLD}Static Hands for macOS${NC}"

    if [ "$CONFIG_ONLY" -eq 0 ]; then
        if [ -d "$KARABINER_APP" ]; then
            ok "Karabiner-Elements is already installed"
        else
            install_karabiner
            [ -d "$KARABINER_APP" ] || fail "Karabiner-Elements was not installed. Finish its installer, then run this again."
            ok "Karabiner-Elements installed"
        fi
    fi

    install_rules
    enable_rules
    finish
}

main
