#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
BUILD_DIR="$PROJECT_ROOT/build"
APP_NAME="VideoGrid"
BUNDLE_PATH="$BUILD_DIR/${APP_NAME}.app"
DIST_DIR="$PROJECT_ROOT/dist"
DMG_NAME="${APP_NAME}-Installer.dmg"
VOLUME_NAME="${APP_NAME} Installer"

if [ ! -d "$BUNDLE_PATH" ]; then
  echo "App bundle not found in $BUNDLE_PATH. Run scripts/build-app.sh first."
  exit 1
fi

if ! command -v hdiutil >/dev/null 2>&1; then
  echo "hdiutil is not available on this system. Cannot create DMG."
  exit 1
fi

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

TEMP_DIR=$(mktemp -d /tmp/videogrid-temp-XXXXXX)
TEMP_DMG="$TEMP_DIR/videogrid-temp.dmg"
MOUNT_DIR=$(mktemp -d /tmp/videogrid-mount-XXXXXX)

DEVICE=""
cleanup() {
  if mount | grep -q "$MOUNT_DIR"; then
    if [ -n "$DEVICE" ]; then
      hdiutil detach "$DEVICE" >/dev/null 2>&1 || true
    fi
  fi
  rm -rf "$MOUNT_DIR"
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

hdiutil create \
  -size 128m \
  -fs HFS+ \
  -layout SPUD \
  -volname "$VOLUME_NAME" \
  "$TEMP_DMG" >/dev/null

DEVICE=$(hdiutil attach "$TEMP_DMG" -mountpoint "$MOUNT_DIR" -nobrowse -noverify | awk '/^\/dev/{print $1; exit}')

cp -R "$BUNDLE_PATH" "$MOUNT_DIR/"
ln -s /Applications "$MOUNT_DIR/Applications"

hdiutil detach "$DEVICE" >/dev/null

DMG_PATH="$DIST_DIR/$DMG_NAME"
hdiutil convert "$TEMP_DMG" \
  -format UDZO \
  -imagekey zlib-level=9 \
  -ov \
  -o "$DMG_PATH" >/dev/null

echo "DMG installer created at $DMG_PATH"
