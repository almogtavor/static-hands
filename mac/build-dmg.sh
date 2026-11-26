#!/bin/bash
#
# Builds StaticHands.dmg, the download offered on the docs site.
# Usage: ./mac/build-dmg.sh [output.dmg]
#
# The DMG holds one visible item, "Install Static Hands.command" (a copy of
# install.sh), plus a hidden copy of the rules so it also works offline.

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="${1:-$HERE/../site/static-hands-docs/static/downloads/StaticHands.dmg}"
CONFIG_NAME="static-hands-basic-macos.json"

STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

cp "$HERE/install.sh" "$STAGE/Install Static Hands.command"
chmod 755 "$STAGE/Install Static Hands.command"
cp "$HERE/$CONFIG_NAME" "$STAGE/.$CONFIG_NAME"

mkdir -p "$(dirname "$OUT")"
rm -f "$OUT"
hdiutil create -volname "Static Hands" -srcfolder "$STAGE" -fs HFS+ -format UDZO -ov -quiet "$OUT"

echo "Built $OUT ($(du -h "$OUT" | cut -f1))"
