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

# ── zshrc baseline ────────────────────────────────────────────────────────────
# Copy baseline to home folder
cp "$DOTFILES_DIR/zshrc_baseline" "$HOME/.zshrc_baseline"
echo "Copied zshrc_baseline to ~/.zshrc_baseline"

# Add source line to ~/.zshrc if not already there
if ! grep -q 'source ~/.zshrc_baseline' "$HOME/.zshrc" 2>/dev/null; then
  echo 'source ~/.zshrc_baseline' >> "$HOME/.zshrc"
  echo "Added 'source ~/.zshrc_baseline' to ~/.zshrc"
else
  echo "~/.zshrc already sources baseline."
fi

echo ""
echo "Done! Run: exec zsh"
