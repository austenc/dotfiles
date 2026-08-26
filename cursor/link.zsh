#!/bin/zsh

# Symlink Cursor config from this repo into the places Cursor actually reads.
# Safe to re-run. Existing files are moved aside, not deleted.

DOTFILES="${DOTFILES:-$HOME/Code/dotfiles}"
SRC="$DOTFILES/cursor"
BACKUP_ROOT="${CURSOR_DOTFILES_BACKUP:-$HOME/.cursor/dotfiles-backup}"

link_path() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ] && [ ! -L "$src" ]; then
        echo "\033[1;33m⚠️   Missing source, skipped: $src\033[0m"
        return 0
    fi

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ]; then
        local current
        current="$(readlink "$dest")"
        if [ "$current" = "$src" ]; then
            echo "\033[1;32m🔗  Already linked: $dest\033[0m"
            return 0
        fi
        rm "$dest"
    elif [ -e "$dest" ]; then
        local stamp backup
        stamp="$(date +%Y%m%d-%H%M%S)"
        backup="$BACKUP_ROOT/$stamp${dest#$HOME}"
        mkdir -p "$(dirname "$backup")"
        mv "$dest" "$backup"
        echo "\033[1;33m📦  Backed up $dest → $backup\033[0m"
    fi

    ln -s "$src" "$dest"
    echo "\033[1;32m🔗  Linked $dest → $src\033[0m"
}

echo "\033[1;32m🖱️   Linking Cursor config from $SRC\033[0m"

link_path "$SRC/skills" "$HOME/.cursor/skills"
link_path "$SRC/rules" "$HOME/.cursor/rules"
