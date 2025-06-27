#!/bin/bash
set -e

echo "Starting dotfiles install script using symlinks..."

DOTFILES=(.bashrc .gitconfig .pylintrc .clang-format)

for file in "${DOTFILES[@]}"; do
    TARGET="$HOME/$file"
    SOURCE="$(pwd)/$file"
    # Backup existing file if it exists and is not a symlink
    if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
        mv "$TARGET" "$TARGET.bak"
        echo "Backed up $TARGET to $TARGET.bak"
    fi
    # Remove existing symlink if present
    if [ -L "$TARGET" ]; then
        rm "$TARGET"
    fi
    # Create symlink if source file exists
    if [ -f "$SOURCE" ]; then
        ln -s "$SOURCE" "$TARGET"
        echo "Symlinked $SOURCE to $TARGET"
    else
        echo "Warning: $SOURCE not found."
    fi
done

# Run optional setup scripts
for script in scripts/setup-aliases.sh scripts/setup-vim.sh; do
    if [ -f "$script" ]; then
        bash "$script"
    fi
done

echo "Dotfiles symlink installation complete!"
