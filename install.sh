#!/usr/bin/env bash
# ClawTelemetry installer (macOS + Linux)
# GitHub-only distribution: installs from a GitHub tag/ref archive.
# Usage: curl -fsSL https://raw.githubusercontent.com/plgonzalezrx8/clawtelemetry/main/install.sh | bash
set -euo pipefail

REPO="${CLAWTELEMETRY_REPO:-plgonzalezrx8/clawtelemetry}"
VERSION="${CLAWTELEMETRY_VERSION:-}"
REF="${CLAWTELEMETRY_REF:-}"
INSTALL_DIR="${CLAWTELEMETRY_INSTALL_DIR:-$HOME/.clawtelemetry}"
BIN_DIR="${CLAWTELEMETRY_BIN_DIR:-$HOME/.local/bin}"

echo "🔭 Installing ClawTelemetry from GitHub"
echo ""

if ! command -v python3 >/dev/null 2>&1; then
  echo "❌ Python 3 is required but was not found."
  exit 1
fi

if [[ -z "$VERSION" && -z "$REF" ]]; then
  echo "→ Resolving latest release tag from GitHub..."
  VERSION="$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" | sed -n 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1)"
  if [[ -z "$VERSION" ]]; then
    echo "❌ Could not resolve latest release tag."
    echo "   Set CLAWTELEMETRY_VERSION=<tag> or CLAWTELEMETRY_REF=<branch-or-sha> and retry."
    exit 1
  fi
fi

TMP_DIR="$(mktemp -d)"
ARCHIVE_PATH="$TMP_DIR/clawtelemetry.tar.gz"

if [[ -n "$REF" ]]; then
  echo "→ Installing from ref: $REF"
  ARCHIVE_URL="https://github.com/${REPO}/archive/${REF}.tar.gz"
else
  ARCHIVE_URL="https://github.com/${REPO}/archive/refs/tags/${VERSION}.tar.gz"
  echo "→ Installing from release tag: $VERSION"
fi

echo "→ Downloading source archive..."
if [[ -n "$REF" ]]; then
  # GitHub supports SHA refs at /archive/<sha>.tar.gz and branches at
  # /archive/refs/heads/<branch>.tar.gz. Try both for reliability.
  if ! curl -fsSL "$ARCHIVE_URL" -o "$ARCHIVE_PATH"; then
    ALT_ARCHIVE_URL="https://github.com/${REPO}/archive/refs/heads/${REF}.tar.gz"
    curl -fsSL "$ALT_ARCHIVE_URL" -o "$ARCHIVE_PATH"
  fi
else
  curl -fsSL "$ARCHIVE_URL" -o "$ARCHIVE_PATH"
fi

echo "→ Extracting archive..."
tar -xzf "$ARCHIVE_PATH" -C "$TMP_DIR"
SRC_DIR="$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
if [[ -z "$SRC_DIR" ]]; then
  echo "❌ Failed to locate extracted source directory."
  exit 1
fi

echo "→ Creating virtual environment at $INSTALL_DIR"
rm -rf "$INSTALL_DIR"
python3 -m venv "$INSTALL_DIR"
"$INSTALL_DIR/bin/pip" install --upgrade pip >/dev/null

echo "→ Installing ClawTelemetry from local source archive"
"$INSTALL_DIR/bin/pip" install --no-cache-dir "$SRC_DIR" >/dev/null

mkdir -p "$BIN_DIR"
ln -sf "$INSTALL_DIR/bin/clawtelemetry" "$BIN_DIR/clawtelemetry"

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo ""
  echo "⚠️  Add $BIN_DIR to your PATH if needed:"
  echo "   export PATH=\"$BIN_DIR:\$PATH\""
fi

echo ""
echo "✅ ClawTelemetry installed successfully"
echo ""
echo "  Run:"
echo "    clawtelemetry --host 0.0.0.0 --port 8900"
echo ""
echo "  Docs: https://github.com/plgonzalezrx8/clawtelemetry/tree/main/docs"

rm -rf "$TMP_DIR"
