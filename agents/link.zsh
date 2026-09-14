#!/bin/zsh

# Symlink skills and instructions into place.
# Safe to re-run. Existing files are moved aside, not deleted.

DOTFILES="${DOTFILES:-$HOME/Code/dotfiles}"
SRC="$DOTFILES/agents"
BACKUP_ROOT="${AGENTS_DOTFILES_BACKUP:-$HOME/.agents/dotfiles-backup}"

link_path() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ] && [ ! -L "$src" ]; then
        echo "\033[1;33m⚠️   Missing source, skipped: $src\033[0m"
        return 0
    fi

    mkdir -p "$(dirname "$dest")" || return 1

    if [ -L "$dest" ]; then
        local current
        current="$(readlink "$dest")"
        if [ "$current" = "$src" ]; then
            echo "\033[1;32m🔗  Already linked: $dest\033[0m"
            return 0
        fi
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        local stamp backup
        mkdir -p "$BACKUP_ROOT" || return 1
        stamp="$(mktemp -d "$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S).XXXXXX")" || return 1
        backup="$stamp${dest#$HOME}"
        mkdir -p "$(dirname "$backup")" || return 1
        mv "$dest" "$backup" || return 1
        echo "\033[1;33m📦  Backed up $dest → $backup\033[0m"
    fi

    ln -s "$src" "$dest" || return 1
    echo "\033[1;32m🔗  Linked $dest → $src\033[0m"
}

echo "\033[1;32m🖱️   Linking skills and instructions from $SRC\033[0m"

link_path "$SRC/skills" "$HOME/.cursor/skills" || return 1
link_path "$SRC/rules" "$HOME/.cursor/rules" || return 1
link_path "$SRC/skills" "$HOME/.agents/skills" || return 1
link_path "$SRC/AGENTS.md" "${CODEX_HOME:-$HOME/.codex}/AGENTS.md" || return 1
