Simple CapsLock-based navigation. Perfect for getting started.

## Installation

Open the **Terminal** app, paste this line and press Enter:
```bash
curl -fsSL https://raw.githubusercontent.com/almogtavor/static-hands/main/mac/install.sh | bash
```

The [installation guide](https://almogtavor.github.io/static-hands/docs/intro) shows every step with pictures.

The installer installs [Karabiner-Elements](https://karabiner-elements.pqrs.org/) if it is missing, copies the rules and enables them in your active Karabiner profile (your previous `karabiner.json` is backed up to `~/.config/karabiner/backups`). The only manual part is approving Karabiner-Elements when macOS asks: background services, Accessibility, Input Monitoring and the Driver Extension.

## Key Mappings

### Navigation
```
CapsLock + I/K/J/L = Arrows (↑/←/↓/→)
CapsLock + U/O = Line Start/End (⌘←/⌘→)
CapsLock + Y/N = Page Up/Down
CapsLock + H = Delete
CapsLock alone = Escape
```

**Note on macOS Home/End behavior:**
- `U` jumps to **start of line** (not document start)
- `O` jumps to **end of line** (not document end)
- This matches standard macOS keyboard behavior (⌘← and ⌘→)

## Usage Examples

**Basic navigation:**
```
CapsLock + I = Move up
CapsLock + K = Move down
CapsLock + J = Move left
CapsLock + L = Move right
```

**Jump to line boundaries:**
```
CapsLock + U = Jump to start of current line
CapsLock + O = Jump to end of current line
```

**Page through documents:**
```
CapsLock + Y = Page up
CapsLock + N = Page down
```

## Troubleshooting

**Keys not working?**
- Check Karabiner-Elements is running
- Verify the rule is **enabled** (not just added) in Complex Modifications
- Turn on all three approvals in System Settings (nothing works until they are on):
  1. General → Login Items & Extensions → Allow in the Background: every Karabiner-Elements entry (some are listed as "Fumihiko Takayama")
  2. Same page → Extensions → Driver Extensions → ⓘ: `Karabiner-DriverKit-VirtualHIDDevice`
  3. Privacy & Security → Input Monitoring: `Karabiner-Core-Service`

**Need document start/end instead of line start/end?**
- Basic edition only supports line start/end
- Upgrade to Advanced edition for document navigation
- Advanced includes modifier keys (W/S/D/F) for extended functionality

**Manual rule enable:**
1. Open Karabiner-Elements
2. Complex Modifications → Add rule
3. Enable "Static Hands - Basic (macOS)"

## Upgrade to Advanced

Want more features? The Advanced edition includes:

- **Modifier modes** (W/S/D/F) for Command/Shift/Option/Control
- **Text editing** (Copy/Paste/Cut/Undo/Bold)
- **Case transformation** (UPPERCASE/lowercase/Title Case)
- **Speed navigation** (jump 5 lines, 6 words)
- **Document start/end** (via CapsLock + W + I/K)
- **Google Search** integration
- And much more!
```bash
cd ../Advanced/
chmod +x install.sh
./install.sh
```

## Files

- `static-hands-basic-macos.json` - Configuration file
- `install.sh` - Installation script
- `README.md` - This file

---

MIT License | Requires: macOS 10.15+, Karabiner-Elements