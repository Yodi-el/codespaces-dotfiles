#!/bin/bash
set -e

echo "Starting dotfiles install script..."

# Symlink or copy config files
cp .bashrc ~/.bashrc
cp .gitconfig ~/.gitconfig
cp .pylintrc ~/.pylintrc
cp .clang-format ~/.clang-format

# Run optional setup scripts
if [ -f scripts/setup-aliases.sh ]; then
    bash scripts/setup-aliases.sh
fi

if [ -f scripts/setup-vim.sh ]; then
    bash scripts/setup-vim.sh
fi

echo "Dotfiles installation complete!"
