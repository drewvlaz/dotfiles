#!/usr/bin/env bash
# Bootstrap a fresh Mac with these dotfiles.
# Safe to re-run — every step is idempotent.

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
TPM_DIR="$HOME/.config/tmux/plugins/tpm"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*" >&2; }

if [[ "$(uname -s)" != "Darwin" ]]; then
    warn "This installer targets macOS. Detected: $(uname -s)"
    exit 1
fi

# 1. Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
    log "Installing Xcode Command Line Tools (GUI prompt)…"
    xcode-select --install
    warn "Re-run this script after the CLT install finishes."
    exit 0
fi

# 2. Homebrew
if ! command -v brew >/dev/null 2>&1; then
    log "Installing Homebrew…"
    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Wire brew into the current shell (Apple Silicon + Intel)
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# 3. Brewfile
log "Installing packages from Brewfile…"
brew bundle --file="$DOTFILES/Brewfile"

# 4. Stow symlinks
log "Linking dotfiles into \$HOME with stow…"
pkg="$(basename "$DOTFILES")"
# Detect conflicts via stow simulation; back up offending files only.
conflicts=$(cd "$HOME" && stow --target="$HOME" --no --verbose=2 "$pkg" 2>&1 \
    | awk '/existing target is .* neither a link nor a directory/ {print $NF}' \
    | sed 's/:$//')

if [[ -n "$conflicts" ]]; then
    backup="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    warn "Conflicting files detected; moving to $backup"
    mkdir -p "$backup"
    while IFS= read -r rel; do
        [[ -z "$rel" ]] && continue
        src="$HOME/$rel"
        dest="$backup/$rel"
        mkdir -p "$(dirname "$dest")"
        mv "$src" "$dest"
    done <<<"$conflicts"
fi

(cd "$HOME" && stow --target="$HOME" --restow "$pkg")

# 5. Tmux plugin manager
if [[ ! -d "$TPM_DIR" ]]; then
    log "Installing tmux plugin manager (TPM)…"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# 6. Default shell -> zsh (brew zsh if installed, else system)
desired_shell="$(command -v zsh)"
if [[ -n "$desired_shell" && "$SHELL" != "$desired_shell" ]]; then
    if ! grep -Fxq "$desired_shell" /etc/shells; then
        log "Adding $desired_shell to /etc/shells (sudo)…"
        echo "$desired_shell" | sudo tee -a /etc/shells >/dev/null
    fi
    log "Setting default shell to $desired_shell…"
    chsh -s "$desired_shell"
fi

log "Done. Open a new terminal, then inside tmux press prefix + I to install plugins."
