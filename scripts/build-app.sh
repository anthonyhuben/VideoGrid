#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
BUILD_DIR="$PROJECT_ROOT/build"
APP_NAME="VideoGrid"
BUNDLE_NAME="${APP_NAME}.app"
BUNDLE_PATH="$BUILD_DIR/$BUNDLE_NAME"
INFO_PLIST_TEMPLATE="$PROJECT_ROOT/packaging/Info.plist"
SOURCE="$PROJECT_ROOT/src/main.m"
HTML_SOURCE="$PROJECT_ROOT/VideoGrid.html"
ICON_SOURCE="$PROJECT_ROOT/packaging/VideoGrid.icns"

if [ ! -f "$HTML_SOURCE" ]; then
  echo "Cannot find $HTML_SOURCE"
  exit 1
fi

rm -rf "$BUILD_DIR"
mkdir -p "$BUNDLE_PATH/Contents/MacOS" "$BUNDLE_PATH/Contents/Resources"
cp "$INFO_PLIST_TEMPLATE" "$BUNDLE_PATH/Contents/Info.plist"
cp "$HTML_SOURCE" "$BUNDLE_PATH/Contents/Resources/VideoGrid.html"
if [ -f "$ICON_SOURCE" ]; then
  cp "$ICON_SOURCE" "$BUNDLE_PATH/Contents/Resources/VideoGrid.icns"
else
  echo "Warning: ${ICON_SOURCE##*/} not found; bundle will not have a custom icon."
fi

echo "Compiling Objective-C source..."
clang -fobjc-arc \
  -mmacosx-version-min=11.0 \
  -arch arm64 \
  -arch x86_64 \
  -framework Cocoa \
  -framework WebKit \
  "$SOURCE" \
  -o "$BUNDLE_PATH/Contents/MacOS/$APP_NAME"

chmod +x "$BUNDLE_PATH/Contents/MacOS/$APP_NAME"

echo "Built macOS app at $BUNDLE_PATH"
