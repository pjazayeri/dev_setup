#!/usr/bin/env bash
# setup.sh — Bootstrap a new macOS machine.
# Safe to run multiple times.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for this session (Apple Silicon)
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew already installed."
fi

# ── iTerm2 ────────────────────────────────────────────────────────────────────
if [[ ! -d "/Applications/iTerm.app" ]]; then
  echo "Installing iTerm2..."
  brew install --cask iterm2
else
  echo "iTerm2 already installed."
fi

# ── Chrome ────────────────────────────────────────────────────────────────────
if [[ ! -d "/Applications/Google Chrome.app" ]]; then
  echo "Installing Google Chrome..."
  brew install --cask google-chrome
else
  echo "Google Chrome already installed."
fi

# ── .zshrc symlink ────────────────────────────────────────────────────────────
SRC="$DOTFILES_DIR/.zshrc"
DST="$HOME/.zshrc"

# Already pointing to the right place — skip
if [[ -L "$DST" && "$(readlink "$DST")" == "$SRC" ]]; then
  echo ".zshrc already symlinked."
else
  # Back up any existing file
  if [[ -e "$DST" || -L "$DST" ]]; then
    mv "$DST" "${DST}.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backed up existing .zshrc"
  fi
  ln -s "$SRC" "$DST"
  echo "Symlinked ~/.zshrc -> $SRC"
fi

echo ""
echo "Done! Run: exec zsh"
